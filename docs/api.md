# API

Базовый URL: `http://localhost:8000/api`

## Auth
### POST `/auth/register`
```
{
  "full_name": "Иван Петров",
  "email": "user@local.dev",
  "password": "secret",
  "role": "student"
}
```

### POST `/auth/login`
```
{
  "login": "user@local.dev",
  "password": "secret"
}
```

### POST `/auth/refresh`
```
{
  "refresh_token": "<token>"
}
```

## Tables (универсальный CRUD)
### GET `/tables/{table}`
Параметры:
- `eq=field:value`
- `neq=field:value`
- `gt=field:value`
- `gte=field:value`
- `lt=field:value`
- `lte=field:value`
- `contains=field:value`
- `in=field:value1,value2`
- `order=field:asc|desc`
- `limit=10`
- `offset=0`

Пример:
```
GET /tables/users?eq=auth_id:seed-student&limit=1
```

### POST `/tables/{table}`
Тело — JSON объекта строки.

### PATCH `/tables/{table}`
Фильтры задаются как в GET, тело — JSON с обновлениями.

### DELETE `/tables/{table}`
Фильтры задаются как в GET.

## Schedule
### GET `/schedule?group=24-Ю041о&date=YYYY-MM-DD`
Возвращает список пар. В ответе:
```
[
  {
    "subject_name": "История государства",
    "start_time": "09:00",
    "end_time": "10:30",
    "classroom": "Ауд. 101",
    "class_type": "лекция",
    "teacher_name": "Иванов И.И.",
    "group_name": "24-Ю041о"
  }
]
```

## Storage
### POST `/storage/upload`
FormData:
- `bucket`: имя корзины
- `file`: бинарный файл

Ответ:
```
{ "url": "/storage/<bucket>/<filename>" }
```

## TODO
- Ограничить доступ к таблицам ролями и JWT.
- Реализовать полноценное удаление/листинг файлов в Storage.
