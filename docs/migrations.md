# Структура БД

Миграции находятся в `backend/alembic/versions/0001_init.py`.

## Основные таблицы
- `users`
- `students`
- `teachers`
- `groups`
- `subjects`
- `subject_groups`
- `schedule`
- `class_sessions`
- `student_subject_grades`
- `student_performance`
- `student_works`
- `assignments`
- `testassignments`
- `work`
- `group_statement`
- `events`
- `event_participation`
- `notifications`
- `schedule_cache`

## Индексы
- `users.auth_id`
- `students.user_id`
- `students.group_id`
- `subjects.teacher_id`
- `schedule(group_id, schedule_date)`
- `schedule_cache(group_name, schedule_date)`

## TODO
- Перенести остальные таблицы из текущей схемы Supabase:
  - `recommendations`, `resources`, `subject_topics`, `finance`, `filter_*`, `updates`, `verified_works`, `v_user_subject_points`, `top`, `spiritually`, `tema`, `check_disable`, `changeteacher`, `change`, `current_date_table`
- Добавить внешние ключи/связи для всех таблиц, где они подразумеваются.
