from datetime import datetime, timezone
from typing import Any, Dict, List

from sqlalchemy import text
from sqlalchemy.orm import Session
from playwright.async_api import async_playwright

from app.core.config import settings


def _get_cached(db: Session, group: str, date: str):
    row = db.execute(
        text(
            """
            SELECT payload, fetched_at
            FROM schedule_cache
            WHERE group_name = :group_name AND schedule_date = :schedule_date
            ORDER BY fetched_at DESC
            LIMIT 1
            """
        ),
        {"group_name": group, "schedule_date": date},
    ).mappings().first()
    if not row:
        return None
    fetched_at = row["fetched_at"]
    if fetched_at is None:
        return None
    age = datetime.now(timezone.utc) - fetched_at
    if age.total_seconds() <= settings.schedule_cache_ttl_seconds:
        return row["payload"]
    return None


def _get_last_payload(db: Session, group: str, date: str):
    row = db.execute(
        text(
            """
            SELECT payload
            FROM schedule_cache
            WHERE group_name = :group_name AND schedule_date = :schedule_date
            ORDER BY fetched_at DESC
            LIMIT 1
            """
        ),
        {"group_name": group, "schedule_date": date},
    ).mappings().first()
    if not row:
        return None
    return row["payload"]


def _normalize_payload(payload: List[Dict[str, Any]]) -> List[Dict[str, str]]:
    normalized: List[Dict[str, str]] = []
    for item in payload or []:
        normalized.append(
            {
                "day_of_week": str(item.get("day_of_week") or ""),
                "time": str(item.get("time") or ""),
                "subject": str(item.get("subject") or item.get("subject_name") or ""),
                "lecturer": str(
                    item.get("lecturer") or item.get("teacher_name") or ""
                ),
                "room": str(item.get("room") or item.get("classroom") or ""),
            }
        )
    normalized.sort(
        key=lambda x: (
            x["day_of_week"],
            x["time"],
            x["subject"],
            x["lecturer"],
            x["room"],
        )
    )
    return normalized


def _notify_schedule_change(
    db: Session, group: str, date: str, old_payload, new_payload
):
    if old_payload is None:
        return
    if _normalize_payload(old_payload) == _normalize_payload(new_payload):
        return

    group_row = db.execute(
        text("SELECT group_id FROM groups WHERE group_name = :group_name LIMIT 1"),
        {"group_name": group},
    ).mappings().first()
    if not group_row:
        return
    group_id = group_row["group_id"]

    student_rows = db.execute(
        text("SELECT user_id FROM students WHERE group_id = :group_id"),
        {"group_id": group_id},
    ).mappings().all()
    if not student_rows:
        return

    now = datetime.now(timezone.utc)
    title = "Изменения в расписании"
    message = f"Расписание группы {group} на {date} изменилось."
    for row in student_rows:
        db.execute(
            text(
                """
                INSERT INTO notifications (user_id, title, message, created_at, is_red)
                VALUES (:user_id, :title, :message, :created_at, :is_red)
                """
            ),
            {
                "user_id": row["user_id"],
                "title": title,
                "message": message,
                "created_at": now,
                "is_red": True,
            },
        )
    db.commit()


def _store_cache(db: Session, group: str, date: str, payload: List[Dict[str, Any]]):
    old_payload = _get_last_payload(db, group, date)
    db.execute(
        text(
            """
            INSERT INTO schedule_cache (group_name, schedule_date, payload, fetched_at)
            VALUES (:group_name, :schedule_date, :payload, :fetched_at)
            """
        ),
        {
            "group_name": group,
            "schedule_date": date,
            "payload": payload,
            "fetched_at": datetime.now(timezone.utc),
        },
    )
    db.commit()
    _notify_schedule_change(db, group, date, old_payload, payload)


async def fetch_schedule_from_web(group: str, date: str) -> List[Dict[str, Any]]:
    """
    Парсинг расписания с https://my.ranepa.ru/schedule/
    Селекторы могут потребовать уточнения под актуальную вёрстку страницы.
    """
    url = "https://my.ranepa.ru/schedule/"
    try:
        async with async_playwright() as p:
            browser = await p.chromium.launch(headless=True)
            page = await browser.new_page(
                user_agent=(
                    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
                    "AppleWebKit/537.36 (KHTML, like Gecko) "
                    "Chrome/120.0.0.0 Safari/537.36"
                )
            )
            await page.goto(url, wait_until="domcontentloaded", timeout=30000)

            # Попытка выбрать группу
            group_input = await page.query_selector(
                "input[name='group'], input[placeholder*='групп'], input[placeholder*='Групп']"
            )
            if group_input:
                await group_input.fill(group)
                await group_input.press("Enter")

            # Попытка выбрать дату
            date_input = await page.query_selector("input[type='date']")
            if date_input:
                await date_input.fill(date)

            await page.wait_for_timeout(1500)

            data = await page.evaluate(
            """
            () => {
              const rows = [];
              const candidates = document.querySelectorAll(
                'table tr, .schedule-row, .pair-row, .rasp-table tr'
              );
              candidates.forEach((row) => {
                const cells = Array.from(row.querySelectorAll('td, .cell, .col'))
                  .map((el) => el.innerText.trim())
                  .filter(Boolean);
                if (cells.length < 3) return;

                // Попытка маппинга колонок.
                const time = cells[0] || '';
                const subject = cells[1] || '';
                const lecturer = cells[2] || '';
                const room = cells[3] || '';
                const day = cells[4] || '';

                rows.push({
                  time,
                  subject,
                  lecturer,
                  room,
                  day_of_week: day,
                });
              });
              return rows;
            }
            """
            )
            await browser.close()

        if not isinstance(data, list):
            data = []

        # Нормализуем формат ответа
        normalized = []
        for item in data:
            time = item.get("time", "")
            start_time, end_time = "", ""
            if "-" in str(time):
                parts = str(time).split("-")
                start_time = parts[0].strip()
                end_time = parts[1].strip() if len(parts) > 1 else ""
            normalized.append(
                {
                    "group_name": group,
                    "date": date,
                    "day_of_week": item.get("day_of_week") or "",
                    "lecturer": item.get("lecturer") or "",
                    "time": time,
                    "room": item.get("room") or "",
                    "subject": item.get("subject") or "",
                    "start_time": start_time,
                    "end_time": end_time,
                    "class_type": "",
                    "teacher_name": item.get("lecturer") or "",
                    "subject_name": item.get("subject") or "",
                    "classroom": item.get("room") or "",
                }
            )
        return normalized
    except Exception:
        return []


async def get_schedule(db: Session, group: str, date: str) -> List[Dict[str, Any]]:
    cached = _get_cached(db, group, date)
    if cached is not None:
        return cached

    payload = await fetch_schedule_from_web(group, date)
    for item in payload:
        item.setdefault("group_name", group)
    _store_cache(db, group, date, payload)
    return payload


async def refresh_today_for_groups(db: Session):
    today = datetime.now().date().isoformat()
    rows = db.execute(text("SELECT group_name FROM groups")).mappings().all()
    for row in rows:
        group_name = row.get("group_name")
        if not group_name:
            continue
        payload = await fetch_schedule_from_web(group_name, today)
        for item in payload:
            item.setdefault("group_name", group_name)
        _store_cache(db, group_name, today, payload)
