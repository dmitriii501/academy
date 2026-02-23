from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import text

from app.db.session import get_db
from app.schemas.auth import LoginRequest, RegisterRequest, RefreshRequest, TokenResponse
from app.services.auth_service import register_user, login_user
from app.core.security import create_access_token, create_refresh_token
from jose import jwt, JWTError
from app.core.config import settings

router = APIRouter()


@router.post("/register", response_model=TokenResponse)
def register(payload: RegisterRequest, db: Session = Depends(get_db)):
    if payload.role.lower() == "student" and not payload.group_name:
        raise HTTPException(status_code=400, detail="Group name is required")
    created = register_user(
        db,
        full_name=payload.full_name,
        email=payload.email,
        password=payload.password,
        role=payload.role,
        group_name=payload.group_name,
    )
    access = create_access_token(created["auth_id"])
    refresh = create_refresh_token(created["auth_id"])
    return TokenResponse(
        access_token=access,
        refresh_token=refresh,
        user_id=created["user_id"],
        auth_id=created["auth_id"],
        is_teacher=created["is_teacher"],
        superuser=created["superuser"],
    )


@router.post("/login", response_model=TokenResponse)
def login(payload: LoginRequest, db: Session = Depends(get_db)):
    tokens = login_user(db, login=payload.login, password=payload.password)
    if tokens is None:
        raise HTTPException(status_code=401, detail="Invalid credentials")
    return TokenResponse(
        access_token=tokens["access_token"],
        refresh_token=tokens["refresh_token"],
        user_id=tokens["user_id"],
        auth_id=tokens["auth_id"],
        is_teacher=tokens["is_teacher"],
        superuser=tokens["superuser"],
    )


@router.post("/refresh", response_model=TokenResponse)
def refresh(payload: RefreshRequest, db: Session = Depends(get_db)):
    try:
        data = jwt.decode(
            payload.refresh_token,
            settings.jwt_secret,
            algorithms=[settings.jwt_algorithm],
        )
    except JWTError as exc:
        raise HTTPException(status_code=401, detail="Invalid refresh token") from exc

    if data.get("type") != "refresh":
        raise HTTPException(status_code=401, detail="Invalid refresh token")

    auth_id = data.get("sub")
    user_row = db.execute(
        text(
            """
            SELECT user_id, is_teacher, superuser
            FROM users
            WHERE auth_id = :auth_id
            LIMIT 1
            """
        ),
        {"auth_id": auth_id},
    ).mappings().first()
    if user_row is None:
        raise HTTPException(status_code=404, detail="User not found")
    access = create_access_token(auth_id)
    refresh = create_refresh_token(auth_id)
    return TokenResponse(
        access_token=access,
        refresh_token=refresh,
        user_id=user_row["user_id"],
        auth_id=auth_id,
        is_teacher=user_row["is_teacher"],
        superuser=user_row["superuser"],
    )
