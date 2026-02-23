from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.core.config import settings
from app.routers import auth, tables, schedule, storage
from app.db.session import SessionLocal
from app.services.schedule_service import refresh_today_for_groups
from apscheduler.schedulers.asyncio import AsyncIOScheduler
from fastapi.staticfiles import StaticFiles

app = FastAPI(
    title="Prototype App Backend",
    version="1.0.0",
    openapi_url=f"{settings.api_v1_prefix}/openapi.json",
    docs_url=f"{settings.api_v1_prefix}/docs",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth.router, prefix=f"{settings.api_v1_prefix}/auth", tags=["auth"])
app.include_router(
    tables.router, prefix=f"{settings.api_v1_prefix}/tables", tags=["tables"]
)
app.include_router(
    schedule.router, prefix=f"{settings.api_v1_prefix}/schedule", tags=["schedule"]
)
app.include_router(
    storage.router, prefix=f"{settings.api_v1_prefix}/storage", tags=["storage"]
)

app.mount("/storage", StaticFiles(directory="/app/storage"), name="storage")


@app.get("/health")
def health():
    return {"status": "ok"}


@app.on_event("startup")
async def start_scheduler():
    import asyncio

    scheduler = AsyncIOScheduler()

    def job():
        """Синхронная обёртка: запускает асинхронное обновление расписания в отдельном цикле событий."""
        db = SessionLocal()
        try:
            loop = asyncio.new_event_loop()
            asyncio.set_event_loop(loop)
            try:
                loop.run_until_complete(refresh_today_for_groups(db))
            finally:
                loop.close()
        finally:
            db.close()

    scheduler.add_job(job, "interval", minutes=10)
    scheduler.start()
