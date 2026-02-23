from typing import Any, Dict, List, Iterable
from datetime import datetime, timezone
from fastapi import APIRouter, Depends, HTTPException, Request
from sqlalchemy import MetaData, Table, select, update, delete, text
from sqlalchemy.orm import Session

from app.db.session import get_db

router = APIRouter()
metadata = MetaData()


def _get_table(db: Session, table_name: str) -> Table:
    try:
        return Table(table_name, metadata, autoload_with=db.bind)
    except Exception as exc:
        raise HTTPException(status_code=404, detail="Table not found") from exc


def _parse_filters(request: Request) -> Dict[str, List[str]]:
    keys = ["eq", "neq", "gt", "gte", "lt", "lte", "contains", "in"]
    parsed: Dict[str, List[str]] = {}
    for key in keys:
        values = request.query_params.getlist(key)
        expanded: List[str] = []
        for value in values:
            expanded.extend([v for v in value.split("|") if v])
        parsed[key] = expanded
    return parsed


def _coerce_value(col, value: str):
    try:
        py_type = col.type.python_type
        if py_type is bool:
            return value.lower() in {"true", "1", "yes"}
        if py_type in {int, float}:
            return py_type(value)
        return py_type(value)
    except Exception:
        return value


def _apply_filters(query, table: Table, filters: Dict[str, List[str]]):
    for op, items in filters.items():
        for item in items:
            if ":" not in item:
                continue
            field, value = item.split(":", 1)
            if field not in table.c:
                continue
            col = table.c[field]
            coerced = _coerce_value(col, value)
            if op == "eq":
                query = query.where(col == coerced)
            elif op == "neq":
                query = query.where(col != coerced)
            elif op == "gt":
                query = query.where(col > coerced)
            elif op == "gte":
                query = query.where(col >= coerced)
            elif op == "lt":
                query = query.where(col < coerced)
            elif op == "lte":
                query = query.where(col <= coerced)
            elif op == "contains":
                query = query.where(col.ilike(f"%{value}%"))
            elif op == "in":
                values = [_coerce_value(col, v) for v in value.split(",") if v]
                query = query.where(col.in_(values))
    return query


def _safe_int(value) -> int | None:
    if value is None:
        return None
    try:
        return int(value)
    except Exception:
        return None


def _get_teacher_user_id(db: Session, subject_id: int | None) -> int | None:
    if subject_id is None:
        return None
    row = db.execute(
        text(
            """
            SELECT t.user_id AS user_id
            FROM subjects s
            JOIN teachers t ON t.teacher_id = s.teacher_id
            WHERE s.subject_id = :subject_id
            LIMIT 1
            """
        ),
        {"subject_id": subject_id},
    ).mappings().first()
    return row["user_id"] if row else None


def _get_student_user_id(db: Session, student_id: int | None) -> int | None:
    if student_id is None:
        return None
    row = db.execute(
        text(
            """
            SELECT u.user_id AS user_id
            FROM students s
            JOIN users u ON u.user_id = s.user_id
            WHERE s.student_id = :student_id
            LIMIT 1
            """
        ),
        {"student_id": student_id},
    ).mappings().first()
    return row["user_id"] if row else None


def _get_subject_name(db: Session, subject_id: int | None) -> str | None:
    if subject_id is None:
        return None
    row = db.execute(
        text("SELECT subject_name FROM subjects WHERE subject_id = :subject_id"),
        {"subject_id": subject_id},
    ).mappings().first()
    return row["subject_name"] if row else None


def _insert_notification(
    db: Session, user_id: int, title: str, message: str, is_red: bool = True
):
    db.execute(
        text(
            """
            INSERT INTO notifications (user_id, title, message, created_at, is_red)
            VALUES (:user_id, :title, :message, :created_at, :is_red)
            """
        ),
        {
            "user_id": user_id,
            "title": title,
            "message": message,
            "created_at": datetime.now(timezone.utc),
            "is_red": is_red,
        },
    )


def _notify_teacher_on_submission(db: Session, table_name: str, row: Dict[str, Any]):
    subject_id = _safe_int(row.get("subject_id"))
    teacher_user_id = _get_teacher_user_id(db, subject_id)
    if teacher_user_id is None:
        return
    subject_name = _get_subject_name(db, subject_id) or "предмету"
    title = "Новая работа"
    message = f"Поступила новая работа по {subject_name}."
    _insert_notification(db, teacher_user_id, title, message, is_red=True)


def _notify_student_on_review(db: Session, table_name: str, row: Dict[str, Any]):
    student_user_id = _safe_int(row.get("userTableId"))
    if student_user_id is None:
        student_id = _safe_int(row.get("student_id"))
        student_user_id = _get_student_user_id(db, student_id)
    if student_user_id is None:
        return
    subject_id = _safe_int(row.get("subject_id"))
    subject_name = _get_subject_name(db, subject_id) or "предмету"
    title = "Работа проверена"
    message = f"Ваша работа по {subject_name} проверена."
    _insert_notification(db, student_user_id, title, message, is_red=False)


def _maybe_notify_on_create(
    db: Session, table_name: str, row: Dict[str, Any] | None
):
    if not row:
        return
    if table_name not in {"assignments", "testassignments", "student_works"}:
        return
    _notify_teacher_on_submission(db, table_name, row)


def _maybe_notify_on_update(
    db: Session, table_name: str, rows: Iterable[Dict[str, Any]]
):
    if table_name not in {"assignments", "testassignments", "student_works"}:
        return
    for row in rows:
        if table_name in {"assignments", "testassignments"}:
            checked = row.get("is_checked")
            grade = row.get("grade")
            if checked is True or grade is not None:
                _notify_student_on_review(db, table_name, row)
        elif table_name == "student_works":
            checked = row.get("checked")
            points = row.get("points")
            if checked is True or points is not None:
                _notify_student_on_review(db, table_name, row)


@router.get("/{table_name}")
def list_rows(
    table_name: str,
    request: Request,
    db: Session = Depends(get_db),
    limit: int | None = None,
    offset: int | None = None,
    order: str | None = None,
):
    table = _get_table(db, table_name)
    query = select(table)
    query = _apply_filters(query, table, _parse_filters(request))

    if order:
        if ":" in order:
            field, direction = order.split(":", 1)
        else:
            field, direction = order, "asc"
        if field in table.c:
            query = query.order_by(
                table.c[field].desc() if direction == "desc" else table.c[field].asc()
            )

    if limit is not None:
        query = query.limit(limit)
    if offset is not None:
        query = query.offset(offset)

    rows = db.execute(query).mappings().all()
    return [dict(row) for row in rows]


@router.post("/{table_name}")
def create_row(
    table_name: str, payload: Dict[str, Any], db: Session = Depends(get_db)
):
    table = _get_table(db, table_name)
    stmt = table.insert().values(**payload).returning(text("*"))
    row = db.execute(stmt).mappings().first()
    db.commit()
    _maybe_notify_on_create(db, table_name, dict(row) if row else None)
    db.commit()
    return dict(row) if row else {}


@router.patch("/{table_name}")
def update_rows(
    table_name: str,
    payload: Dict[str, Any],
    request: Request,
    db: Session = Depends(get_db),
):
    table = _get_table(db, table_name)
    stmt = update(table).values(**payload)
    stmt = _apply_filters(stmt, table, _parse_filters(request))
    stmt = stmt.returning(text("*"))
    rows = db.execute(stmt).mappings().all()
    db.commit()
    _maybe_notify_on_update(db, table_name, [dict(r) for r in rows])
    db.commit()
    return [dict(row) for row in rows]


@router.delete("/{table_name}")
def delete_rows(
    table_name: str, request: Request, db: Session = Depends(get_db)
):
    table = _get_table(db, table_name)
    stmt = delete(table)
    stmt = _apply_filters(stmt, table, _parse_filters(request))
    stmt = stmt.returning(text("*"))
    rows = db.execute(stmt).mappings().all()
    db.commit()
    return [dict(row) for row in rows]
