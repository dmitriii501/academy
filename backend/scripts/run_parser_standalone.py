#!/usr/bin/env python3
"""
Автономная проверка парсера расписания (только Playwright, без БД и app).
Запуск: python scripts/run_parser_standalone.py 24-Ю041о 2026-02-09
Перед первым запуском: pip install playwright && playwright install chromium
"""
import asyncio
import json
import sys
from playwright.async_api import async_playwright


async def fetch_schedule(group: str, date: str):
    url = "https://my.ranepa.ru/schedule/"
    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=True)
        page = await browser.new_page(
            user_agent=(
                "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
                "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
            )
        )
        await page.goto(url, wait_until="domcontentloaded", timeout=30000)

        group_input = await page.query_selector(
            "input[name='group'], input[placeholder*='групп'], input[placeholder*='Групп']"
        )
        if group_input:
            await group_input.fill(group)
            await group_input.press("Enter")

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
                const time = cells[0] || '';
                const subject = cells[1] || '';
                const lecturer = cells[2] || '';
                const room = cells[3] || '';
                const day = cells[4] || '';
                rows.push({ time, subject, lecturer, room, day_of_week: day });
              });
              return rows;
            }
            """
        )
        await browser.close()
    return data if isinstance(data, list) else []


async def main():
    group = sys.argv[1] if len(sys.argv) > 1 else "24-Ю041о"
    date = sys.argv[2] if len(sys.argv) > 2 else "2026-02-09"
    print(f"Группа: {group}, дата: {date}")
    print("Загрузка https://my.ranepa.ru/schedule/ ...")
    try:
        data = await fetch_schedule(group, date)
        print(f"Получено записей: {len(data)}")
        if data:
            print(json.dumps(data[:10], ensure_ascii=False, indent=2))
            if len(data) > 10:
                print("...")
        else:
            print("Расписание пусто или селекторы не совпали с вёрсткой страницы.")
    except Exception as e:
        print(f"Ошибка: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    asyncio.run(main())
