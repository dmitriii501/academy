from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.db.session import get_db
from app.services.schedule_service import get_schedule

router = APIRouter()


@router.get("/")
async def schedule(group: str, date: str, db: Session = Depends(get_db)):
    return await get_schedule(db, group=group, date=date)
