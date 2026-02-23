import os
from passlib.context import CryptContext
from sqlalchemy import create_engine, text


DATABASE_URL = os.getenv(
    "DATABASE_URL", "postgresql+psycopg2://postgres:postgres@db:5432/prototype_app"
)
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


def run():
    engine = create_engine(DATABASE_URL)
    with engine.begin() as conn:
        student_hash = pwd_context.hash("student123")
        teacher_hash = pwd_context.hash("teacher123")

        conn.execute(
            text(
                """
                INSERT INTO users (full_name, corporate_email, personal_email, auth_id, is_teacher, superuser, password_hash)
                VALUES
                    ('Иван Петров', 'student@ranepa.local', 'student@ranepa.local', 'seed-student', false, false, :student_hash),
                    ('Мария Иванова', 'teacher@ranepa.local', 'teacher@ranepa.local', 'seed-teacher', true, true, :teacher_hash),
                    ('Александр Огородов Сергеевич', 'ogorodov@ranepa.local', 'ogorodov@ranepa.local', 'seed-ogorodov', true, false, :teacher_hash)
                ON CONFLICT DO NOTHING
                """
            ),
            {"student_hash": student_hash, "teacher_hash": teacher_hash},
        )

        conn.execute(
            text(
                """
                INSERT INTO groups (group_name)
                VALUES ('24-Ю041о'), ('24-Ю042о'), ('25-ЭкБ41з')
                ON CONFLICT DO NOTHING
                """
            )
        )

        conn.execute(
            text(
                """
                INSERT INTO teachers (user_id, department)
                SELECT u.user_id, 'Юрфак'
                FROM users u
                WHERE u.auth_id = 'seed-teacher'
                ON CONFLICT DO NOTHING
                """
            )
        )
        conn.execute(
            text(
                """
                INSERT INTO teachers (user_id, department)
                SELECT u.user_id, 'Экономика'
                FROM users u
                WHERE u.auth_id = 'seed-ogorodov'
                ON CONFLICT DO NOTHING
                """
            )
        )

        conn.execute(
            text(
                """
                INSERT INTO students (user_id, group_id, course, form_study)
                SELECT u.user_id, g.group_id, '1', 'Очная'
                FROM users u
                JOIN groups g ON g.group_name = '24-Ю041о'
                WHERE u.auth_id = 'seed-student'
                ON CONFLICT DO NOTHING
                """
            )
        )

        conn.execute(
            text(
                """
                INSERT INTO subjects (subject_name, total_hours, teacher_id, group_id)
                SELECT 'История государства', 72, t.teacher_id, g.group_id
                FROM teachers t
                JOIN groups g ON g.group_name = '24-Ю041о'
                WHERE t.user_id = (SELECT user_id FROM users WHERE auth_id = 'seed-teacher')
                ON CONFLICT DO NOTHING
                """
            )
        )
        conn.execute(
            text(
                """
                INSERT INTO subjects (subject_name, total_hours, teacher_id, group_id)
                SELECT 'Основы российской государственности', 72, t.teacher_id, g.group_id
                FROM teachers t
                JOIN groups g ON g.group_name = '25-ЭкБ41з'
                WHERE t.user_id = (SELECT user_id FROM users WHERE auth_id = 'seed-ogorodov')
                ON CONFLICT DO NOTHING
                """
            )
        )


if __name__ == "__main__":
    run()
