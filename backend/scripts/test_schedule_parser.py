#!/usr/bin/env python3
"""
Проверка работоспособности парсера расписания с https://my.ranepa.ru/schedule/

Запуск из корня backend:
  python scripts/test_schedule_parser.py [группа] [дата]

Примеры:
  python scripts/test_schedule_parser.py
  python scripts/test_schedule_parser.py 25-ЭкБ41з 2025-02-02

Требуется: playwright install chromium (один раз).
"""
import asyncio
import json
import sys
from pathlib import Path

# Добавляем backend в path для импорта app
sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from app.services.schedule_service import fetch_schedule_from_web


async def main():
    group = sys.argv[1] if len(sys.argv) > 1 else "25-ЭкБ41з"
    date = sys.argv[2] if len(sys.argv) > 2 else "2025-02-02"

    print(f"Парсинг расписания: группа={group}, дата={date}")
    print("Источник: https://my.ranepa.ru/schedule/")
    print("-" * 50)

    try:
        data = await fetch_schedule_from_web(group, date)
        print(f"Получено записей: {len(data)}")
        if data:
            print(json.dumps(data[:5], ensure_ascii=False, indent=2))
            if len(data) > 5:
                print("...")
        else:
            print("Расписание пусто или селекторы не совпали с текущей вёрсткой страницы.")
    except Exception as e:
        print(f"Ошибка: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    asyncio.run(main())
