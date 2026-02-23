# Документация проекта Prototype App

## 1) Обзор
`Prototype App` — Flutter-приложение, экспортированное из FlutterFlow, с двумя основными ролями пользователей: студент и преподаватель. Основные сценарии: авторизация, учебные предметы и успеваемость, расписание, посещаемость, ведомости, внеучебная активность, профили и уведомления.

Клиент использует Supabase как backend (Auth, Database, Storage, REST), а также стандартные FlutterFlow-паттерны (FFAppState, GoRouter, FlutterFlow UI-компоненты).

## 2) Технологический стек
- Flutter SDK: `>=3.0.0 <4.0.0`
- Архитектурный стиль: FlutterFlow (UI + Model + FFAppState + GoRouter)
- State management: `Provider` + `FFAppState`
- Навигация: `go_router`
- Backend: `supabase_flutter`
- Доп. библиотеки: `cached_network_image`, `table_calendar`, `data_table_2`, `google_nav_bar`, `image_picker`, `video_player`, `webview_flutter`, `url_launcher` и др.

Список зависимостей — `pubspec.yaml`.

## 3) Структура проекта
Ключевые директории:
- `lib/main.dart` — точка входа, инициализация Supabase и глобального состояния.
- `lib/index.dart` — экспорт основных экранов.
- `lib/flutter_flow/` — базовые утилиты и компоненты FlutterFlow (темы, виджеты, навигация, сериализация).
- `lib/auth/` — менеджер авторизации и провайдер пользователя.
- `lib/backend/` — Supabase-схема и API-обвязка.
- `lib/student/` — экраны студента.
- `lib/teacher/` — экраны преподавателя.
- `lib/user_menu/` — профили/меню/уведомления.
- `lib/custom_code/` — кастомные действия FlutterFlow.
- `assets/` — изображения, видео, аудио, pdf, rive и т.д.

## 4) Инициализация и жизненный цикл
Точка входа — `lib/main.dart`:
- Инициализирует Flutter, URL strategy (для web), Supabase (`SupaFlow.initialize()`).
- Поднимает `FFAppState` и загружает сохранённые данные.
- Подписывается на стрим пользователей Supabase и обновляет `AppStateNotifier`.
- Запускает `MaterialApp.router` с `GoRouter`.

## 5) Навигация и маршруты
Навигация реализована через `GoRouter` и собственный слой `FFRoute` в `lib/flutter_flow/nav/nav.dart`.

Ключевые особенности:
- Есть `AppStateNotifier` (авторизация, splash, редиректы).
- Для закрытых маршрутов используется `requireAuth: true` и редирект на `/authorization`.
- Главная страница после входа — `NavBarPage` с нижней навигацией (Учёба / Календарь / Внеучебка).

### Список маршрутов (routeName / routePath)

#### Авторизация
- `authorization` / `/authorization`

#### Студент
- `my_subjects_student` / `/mySubjectsStudent`
- `schedule_student` / `/scheduleStudent`
- `extra_activities` / `/extraActivities`
- `subject_student` / `/subjectStudent`
- `events` / `/events`
- `leisure` / `/leisure`
- `participate` / `/participate`
- `development_main` / `/developmentMain`
- `tasks` / `/tasks`
- `my_works` / `/myWorks`
- `event_participation` / `/eventParticipation`
- `tasksDebt` / `/tasksDebt`
- `extraTasks` / `/extraTasks`
- `collectives` / `/collectives`
- `debts` / `/debts`
- `performance` / `/performance`
- `extraPoin` / `/extraPoin`

#### Преподаватель
- `my_subjects_teacher` / `/mySubjectsTeacher`
- `schedule_teacher` / `/scheduleTeacher`
- `subject_teacher` / `/subjectTeacher`
- `student_works` / `/studentWorks`
- `attendance` / `/attendance`
- `points` / `/points`
- `groupStatement` / `/groupStatement`
- `statement` / `/statement`

#### Меню и профили
- `profileTeacher` / `/profileTeacher`
- `profileTeacherChange1` / `/profileTeacherChange1`
- `profileTeacherChange2` / `/profileTeacherChange2`
- `profileStudent` / `/profileStudent`
- `profileStudentChange` / `/profileStudentChange`
- `profileStudentchange1` / `/profileStudentchange1`
- `menu_teacher` / `/menuTeacher`
- `menu_stud` / `/menuStud`
- `NotificationsTeacher` / `/notificationsTeacher`
- `NotificationsStud` / `/notificationsStud`

Примечание: фактический набор параметров для некоторых экранов передаётся через `GoRouter` (например, `SubjectsRow`, `UsersRow`, `GroupsRow`).

## 6) Авторизация и роли
Auth реализован через Supabase Email/Password:
- `SupabaseAuthManager` в `lib/auth/supabase_auth/`.
- Поток JWT (`jwtTokenStream`) доступен в `auth_util.dart`.

Логика ролей:
- Роль пользователя определяется через `UsersRow` (`isTeacher`, `superuser`) и используется в `AuthorizationWidget`.
- Для преподавателей и студентов используются отдельные разделы и экраны.

## 7) Состояние приложения (FFAppState)
Глобальное состояние хранится в `lib/app_state.dart`:
- Persisted: `scoreList` (SharedPreferences).
- Флаги контекста (student/teacher), фильтры, сортировка, выбранные параметры.
- Наборы списков для фильтрации/отбора.

`FFAppState` доступен через `Provider` и обновляется методом `update()`.

## 8) Backend и данные (Supabase)
Инициализация Supabase находится в `lib/backend/supabase/supabase.dart`.
Схема и таблицы экспортируются из:
`lib/backend/supabase/database/database.dart`.

### Таблицы Supabase (экспортируемые модели)
- `assignments`
- `change`
- `changeteacher`
- `check_disable`
- `class_sessions`
- `current_date_table`
- `event_participation`
- `events`
- `finance`
- `filterdevelopment`
- `filtergroups`
- `filtnot`
- `filterteacher`
- `filter_works`
- `group_statement`
- `groups`
- `notifications`
- `recommendations`
- `resources`
- `schedule`
- `spiritually`
- `student_performance`
- `student_subject_grades`
- `student_works`
- `students`
- `subject_groups`
- `subject_topics`
- `subjects`
- `teachers`
- `tema`
- `testassignments`
- `top`
- `update`
- `update1`
- `update2`
- `update3`
- `users`
- `v_user_subject_points`
- `work`

Дополнительно:
- `lib/backend/api_requests/api_calls.dart` содержит REST-вызов к Supabase (PATCH).
- `ApiManager` реализует общий клиент для REST-запросов, включая multipart.

## 9) Пользовательские функции и actions
Кастомные функции:
- `filterSubjects`, `filterSubjectsCopy`, `updateTotalPoints` в `lib/flutter_flow/custom_functions.dart`.

Кастомные actions:
- `incrementSupabaseField` в `lib/custom_code/actions/increment_supabase_field.dart` — увеличение числового поля в Supabase.

## 10) Локализация
Поддерживается только русский язык (`ru`).
Локализация управляется в `lib/flutter_flow/internationalization.dart`.

## 11) Ассеты
Ассеты подключены в `pubspec.yaml`:
- `assets/images`, `assets/videos`, `assets/audios`, `assets/pdfs`, `assets/jsons`, `assets/rive_animations`, `assets/fonts`.

## 12) Сборка и запуск
Базовые команды:
- `flutter pub get`
- `flutter run`

Для веб-версии:
- `flutter run -d chrome`

Примечание: проект ориентирован на Flutter Stable (FlutterFlow).

## 13) Тестирование
Есть базовый тест: `test/widget_test.dart`.

## 14) Конфигурация и секреты
В проекте Supabase URL и anon key находятся в коде:
`lib/backend/supabase/supabase.dart`.
Для production рекомендуется вынести ключи в переменные окружения или безопасный конфиг.

## 15) Рекомендуемые улучшения (архитектура)
- Вынести конфигурацию Supabase в отдельный слой конфигурации.
- Добавить единый слой репозиториев для работы с таблицами и API.
- Привести имена routeName/routePath к единому стилю (snake_case или camelCase).
- Добавить тесты бизнес-логики и навигации.


