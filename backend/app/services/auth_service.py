import uuid
from sqlalchemy import text
from sqlalchemy.orm import Session

from app.core.security import (
    create_access_token,
    create_refresh_token,
    get_password_hash,
    verify_password,
)


def register_user(
    db: Session,
    full_name: str,
    email: str,
    password: str,
    role: str,
    group_name: str | None = None,
):
    auth_id = str(uuid.uuid4())
    password_hash = get_password_hash(password)
    is_teacher = role.lower() == "teacher"
    superuser = False

    result = db.execute(
        text(
            """
            INSERT INTO users (full_name, corporate_email, personal_email, auth_id, is_teacher, superuser, password_hash)
            VALUES (:full_name, :email, :email, :auth_id, :is_teacher, :superuser, :password_hash)
            RETURNING user_id
            """
        ),
        {
            "full_name": full_name,
            "email": email,
            "auth_id": auth_id,
            "is_teacher": is_teacher,
            "superuser": superuser,
            "password_hash": password_hash,
        },
    )
    user_id = result.scalar_one()
    if not is_teacher:
        if group_name:
            group_row = db.execute(
                text(
                    """
                    SELECT group_id FROM groups
                    WHERE group_name = :group_name
                    LIMIT 1
                    """
                ),
                {"group_name": group_name},
            ).mappings().first()
            if group_row is None:
                group_row = db.execute(
                    text(
                        """
                        INSERT INTO groups (group_name)
                        VALUES (:group_name)
                        RETURNING group_id
                        """
                    ),
                    {"group_name": group_name},
                ).mappings().first()
            group_id = group_row["group_id"]
            db.execute(
                text(
                    """
                    INSERT INTO students (user_id, group_id)
                    VALUES (:user_id, :group_id)
                    """
                ),
                {"user_id": user_id, "group_id": group_id},
            )
            db.commit()
    return {
        "user_id": user_id,
        "auth_id": auth_id,
        "is_teacher": is_teacher,
        "superuser": superuser,
    }


def login_user(db: Session, login: str, password: str):
    result = db.execute(
        text(
            """
            SELECT user_id, auth_id, is_teacher, superuser, password_hash
            FROM users
            WHERE corporate_email = :login
               OR personal_email = :login
               OR auth_id = :login
            LIMIT 1
            """
        ),
        {"login": login},
    )
    row = result.mappings().first()
    if row is None:
        return None
    if row["password_hash"] is None or not verify_password(password, row["password_hash"]):
        return None
    access = create_access_token(str(row["auth_id"]))
    refresh = create_refresh_token(str(row["auth_id"]))
    return {
        "access_token": access,
        "refresh_token": refresh,
        "user_id": row["user_id"],
        "auth_id": row["auth_id"],
        "is_teacher": row["is_teacher"],
        "superuser": row["superuser"],
    }
