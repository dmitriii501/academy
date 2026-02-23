# Backend setup (локальный запуск)

## Требования
- Docker + Docker Compose

## Запуск
1) Запуск контейнеров:
```
docker compose up -d
```

2) Применить миграции:
```
docker compose exec backend alembic upgrade head
```

3) Засидить тестовые данные:
```
docker compose exec backend python seed/seed.py
```

## Доступ
- API: `http://localhost:8000/api`
- Swagger: `http://localhost:8000/api/docs`
- Healthcheck: `http://localhost:8000/health`
- PgAdmin: `http://localhost:5050`

## Тестовые аккаунты
- Студент: `student@ranepa.local` / `student123`
- Преподаватель: `teacher@ranepa.local` / `teacher123`

## Проверка парсера расписания

Парсер загружает расписание с https://my.ranepa.ru/schedule/ (Playwright, headless Chrome).

1. Один раз установить браузер для Playwright (в контейнере или локально):
   ```
   docker compose exec backend playwright install chromium
   ```
   или локально: `playwright install chromium`

2. Запуск теста парсера без БД (только запрос к сайту и разбор страницы):
   ```
   docker compose exec backend python scripts/test_schedule_parser.py 25-ЭкБ41з 2025-02-02
   ```
   Без аргументов используются группа `25-ЭкБ41з` и дата `2025-02-02`.

3. Если расписание пустое — страница могла измениться или требуется авторизация. Селекторы в `app/services/schedule_service.py` (функция `fetch_schedule_from_web`) нужно уточнить по актуальной вёрстке.

4. Планировщик раз в 10 минут обновляет кэш расписания для всех групп из БД (`refresh_today_for_groups`).

## TODO
- При необходимости настроить парсинг под актуальный DOM и авторизацию на `my.ranepa.ru/schedule`.
