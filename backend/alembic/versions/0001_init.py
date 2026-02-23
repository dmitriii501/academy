"""init schema

Revision ID: 0001_init
Revises: 
Create Date: 2026-02-02 00:00:00.000000

"""
from alembic import op
import sqlalchemy as sa


revision = "0001_init"
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    op.create_table(
        "users",
        sa.Column("user_id", sa.Integer, primary_key=True),
        sa.Column("full_name", sa.Text, nullable=False),
        sa.Column("corporate_email", sa.Text, nullable=True),
        sa.Column("personal_email", sa.Text, nullable=True),
        sa.Column("phone", sa.Text, nullable=True),
        sa.Column("photo_url", sa.Text, nullable=True),
        sa.Column("auth_id", sa.Text, nullable=True, unique=True),
        sa.Column("is_teacher", sa.Boolean, nullable=True),
        sa.Column("superuser", sa.Boolean, nullable=True),
        sa.Column("password_hash", sa.Text, nullable=True),
    )

    op.create_table(
        "groups",
        sa.Column("group_id", sa.Integer, primary_key=True),
        sa.Column("group_name", sa.Text, nullable=False),
    )

    op.create_table(
        "students",
        sa.Column("student_id", sa.Integer, primary_key=True),
        sa.Column("user_id", sa.Integer, sa.ForeignKey("users.user_id")),
        sa.Column("course", sa.Text, nullable=True),
        sa.Column("group_id", sa.Integer, sa.ForeignKey("groups.group_id")),
        sa.Column("form_study", sa.Text, nullable=True),
        sa.Column("birth_date", sa.Date, nullable=True),
        sa.Column("birth_place", sa.Text, nullable=True),
        sa.Column("birth_country", sa.Text, nullable=True),
        sa.Column("average_performance_5", sa.Numeric, nullable=True),
        sa.Column("number", sa.Integer, nullable=True),
    )

    op.create_table(
        "teachers",
        sa.Column("teacher_id", sa.Integer, primary_key=True),
        sa.Column("user_id", sa.Integer, sa.ForeignKey("users.user_id")),
        sa.Column("department", sa.Text, nullable=True),
        sa.Column("birthDate", sa.Date, nullable=True),
        sa.Column("place", sa.Text, nullable=True),
        sa.Column("country", sa.Text, nullable=True),
    )

    op.create_table(
        "subjects",
        sa.Column("subject_id", sa.Integer, primary_key=True),
        sa.Column("subject_name", sa.Text, nullable=False),
        sa.Column("total_hours", sa.Integer, nullable=True),
        sa.Column("color", sa.Text, nullable=True),
        sa.Column("teacher_id", sa.Integer, sa.ForeignKey("teachers.teacher_id")),
        sa.Column("type_of_subject", sa.Text, nullable=True),
        sa.Column("full_name", sa.Text, nullable=True),
        sa.Column("group_id", sa.Integer, sa.ForeignKey("groups.group_id")),
    )

    op.create_table(
        "subject_groups",
        sa.Column("subject_id", sa.Integer, sa.ForeignKey("subjects.subject_id")),
        sa.Column("group_id", sa.Integer, sa.ForeignKey("groups.group_id")),
        sa.Column("exam_type", sa.Text, nullable=False),
    )

    op.create_table(
        "schedule",
        sa.Column("schedule_id", sa.Integer, primary_key=True),
        sa.Column("group_id", sa.Integer, sa.ForeignKey("groups.group_id")),
        sa.Column("subject_id", sa.Integer, sa.ForeignKey("subjects.subject_id")),
        sa.Column("teacher_id", sa.Integer, sa.ForeignKey("teachers.teacher_id")),
        sa.Column("schedule_date", sa.Date, nullable=False),
        sa.Column("start_time-end_time", sa.Text, nullable=False),
        sa.Column("class_type", sa.Text, nullable=True),
        sa.Column("classroom", sa.Text, nullable=True),
    )

    op.create_table(
        "class_sessions",
        sa.Column("session_id", sa.Integer, primary_key=True),
        sa.Column("subject_id", sa.Integer, sa.ForeignKey("subjects.subject_id")),
        sa.Column("group_id", sa.Integer, sa.ForeignKey("groups.group_id")),
        sa.Column("teacher_id", sa.Integer, sa.ForeignKey("teachers.teacher_id")),
        sa.Column("session_date", sa.Date, nullable=False),
        sa.Column("session_type", sa.Text, nullable=True),
        sa.Column("start_time", sa.Time, nullable=False),
        sa.Column("end_time", sa.Time, nullable=False),
        sa.Column("classroom", sa.Text, nullable=True),
    )

    op.create_table(
        "student_subject_grades",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("student_id", sa.Integer, sa.ForeignKey("students.student_id")),
        sa.Column("subject_id", sa.Integer, sa.ForeignKey("subjects.subject_id")),
        sa.Column("final_exam_grade", sa.Numeric, nullable=True),
        sa.Column("student_name", sa.Text, nullable=True),
        sa.Column("group", sa.Integer, nullable=True),
        sa.Column("seminar_attended", sa.Boolean, nullable=True),
        sa.Column("date", sa.Date, nullable=True),
        sa.Column("sem_grade", sa.Integer, nullable=True),
        sa.Column("final_grade", sa.Integer, nullable=True),
    )

    op.create_table(
        "student_performance",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("group_id", sa.Integer, sa.ForeignKey("groups.group_id")),
        sa.Column("student_id", sa.Integer, sa.ForeignKey("students.student_id")),
        sa.Column("subject_id", sa.Integer, sa.ForeignKey("subjects.subject_id")),
        sa.Column("id_of_group_statement", sa.Integer, nullable=True),
        sa.Column("date", sa.Date, nullable=False),
        sa.Column("points_of_work", sa.Integer, nullable=False),
        sa.Column("is_attended", sa.Boolean, nullable=False),
        sa.Column("points_of_attended", sa.Integer, nullable=False),
        sa.Column("reason_of_pass", sa.Text, nullable=True),
    )

    op.create_table(
        "student_works",
        sa.Column("work_id", sa.Integer, primary_key=True),
        sa.Column("student_id", sa.Integer, sa.ForeignKey("students.student_id")),
        sa.Column("subject_id", sa.Integer, sa.ForeignKey("subjects.subject_id")),
        sa.Column("work_type", sa.Text, nullable=True),
        sa.Column("classification", sa.Text, nullable=True),
        sa.Column("topic", sa.Text, nullable=True),
        sa.Column("assigned_date", sa.Date, nullable=True),
        sa.Column("submitted_date", sa.Date, nullable=True),
        sa.Column("link_to_work", sa.Text, nullable=True),
        sa.Column("teacher_comment", sa.Text, nullable=True),
        sa.Column("points", sa.Numeric, nullable=True),
        sa.Column("checked", sa.Boolean, nullable=False, server_default=sa.text("false")),
        sa.Column("checked_date", sa.Date, nullable=True),
    )

    op.create_table(
        "assignments",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("user_id", sa.Text, nullable=True),
        sa.Column("topic_id", sa.Integer, nullable=True),
        sa.Column("file_url", sa.Text, nullable=True),
        sa.Column("status", sa.Text, nullable=True),
        sa.Column("created_at", sa.DateTime, nullable=True),
        sa.Column("userTableId", sa.Integer, nullable=True),
        sa.Column("grade", sa.Integer, nullable=True),
        sa.Column("teacherComment", sa.Text, nullable=True),
        sa.Column("typeOfWork", sa.Text, nullable=True),
        sa.Column("typeOFWorkSecond", sa.Text, nullable=True),
        sa.Column("is_checked", sa.Boolean, nullable=True),
        sa.Column("nameStudent", sa.Text, nullable=True),
        sa.Column("isdelivered", sa.Boolean, nullable=True),
        sa.Column("is_debt", sa.Boolean, nullable=True),
        sa.Column("is_referat", sa.Boolean, nullable=True),
        sa.Column("subject_id", sa.Integer, sa.ForeignKey("subjects.subject_id")),
    )

    op.create_table(
        "testassignments",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("user_id", sa.Text, nullable=True),
        sa.Column("topic_id", sa.Integer, nullable=True),
        sa.Column("file_url", sa.Text, nullable=True),
        sa.Column("status", sa.Text, nullable=True),
        sa.Column("created_at", sa.DateTime, nullable=True),
        sa.Column("userTableId", sa.Integer, nullable=True),
        sa.Column("grade", sa.Integer, nullable=True),
        sa.Column("teacherComment", sa.Text, nullable=True),
        sa.Column("typeOfWork", sa.Text, nullable=True),
        sa.Column("typeOFWorkSecond", sa.Text, nullable=True),
        sa.Column("is_checked", sa.Boolean, nullable=True),
        sa.Column("nameStudent", sa.Text, nullable=True),
        sa.Column("isdelivered", sa.Boolean, nullable=True),
        sa.Column("is_debt", sa.Boolean, nullable=True),
        sa.Column("is_referat", sa.Boolean, nullable=True),
        sa.Column("subject_id", sa.Integer, sa.ForeignKey("subjects.subject_id")),
    )

    op.create_table(
        "work",
        sa.Column("workk", sa.Integer, primary_key=True),
        sa.Column("name", sa.Text, nullable=False),
    )

    op.create_table(
        "group_statement",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("user_id", sa.Integer, sa.ForeignKey("users.user_id")),
        sa.Column("subject_id", sa.Integer, sa.ForeignKey("subjects.subject_id")),
        sa.Column("event_points", sa.Integer, nullable=True),
        sa.Column("assignment_points", sa.Integer, nullable=True),
        sa.Column("total_points", sa.Integer, nullable=True),
        sa.Column("updated_at", sa.DateTime, nullable=True),
        sa.Column("groupid", sa.Integer, nullable=True),
        sa.Column("isAttended", sa.Boolean, nullable=True),
        sa.Column("attended_points", sa.Integer, nullable=True),
        sa.Column("exampoint", sa.Integer, nullable=True),
        sa.Column("pointsOfWorking", sa.Integer, nullable=True),
        sa.Column("reasonOfPass", sa.Text, nullable=True),
        sa.Column("IsLecture", sa.Boolean, nullable=True),
    )

    op.create_table(
        "events",
        sa.Column("event_id", sa.Integer, primary_key=True),
        sa.Column("event_name", sa.Text, nullable=False),
        sa.Column("event_description", sa.Text, nullable=True),
        sa.Column("event_date", sa.Date, nullable=False),
        sa.Column("event_type", sa.Text, nullable=False),
        sa.Column("photo_url", sa.Text, nullable=True),
        sa.Column("is_main", sa.Boolean, nullable=True),
        sa.Column("subject_id_if_event", sa.Integer, nullable=True),
        sa.Column("is_participated", sa.Boolean, nullable=True),
    )

    op.create_table(
        "event_participation",
        sa.Column("participation_id", sa.Integer, primary_key=True),
        sa.Column("event_id", sa.Integer, sa.ForeignKey("events.event_id")),
        sa.Column("user_id", sa.Integer, sa.ForeignKey("users.user_id")),
        sa.Column("subject_id", sa.Integer, nullable=True),
        sa.Column("participated", sa.Boolean, nullable=False),
        sa.Column("is_attended", sa.Boolean, nullable=False),
        sa.Column("fullName", sa.Text, nullable=True),
        sa.Column("is_subject_event", sa.Boolean, nullable=True),
    )

    op.create_table(
        "notifications",
        sa.Column("notification_id", sa.Integer, primary_key=True),
        sa.Column("user_id", sa.Integer, sa.ForeignKey("users.user_id")),
        sa.Column("title", sa.Text, nullable=True),
        sa.Column("message", sa.Text, nullable=True),
        sa.Column("created_at", sa.DateTime, nullable=True),
        sa.Column("read_at", sa.DateTime, nullable=True),
        sa.Column("is_red", sa.Boolean, nullable=True),
    )

    op.create_table(
        "schedule_cache",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("group_name", sa.Text, nullable=False),
        sa.Column("schedule_date", sa.Text, nullable=False),
        sa.Column("payload", sa.JSON, nullable=False),
        sa.Column("fetched_at", sa.DateTime(timezone=True), nullable=False),
    )

    op.create_index("idx_users_auth_id", "users", ["auth_id"])
    op.create_index("idx_students_user_id", "students", ["user_id"])
    op.create_index("idx_students_group_id", "students", ["group_id"])
    op.create_index("idx_subjects_teacher_id", "subjects", ["teacher_id"])
    op.create_index("idx_schedule_group_date", "schedule", ["group_id", "schedule_date"])
    op.create_index(
        "idx_schedule_cache_group_date",
        "schedule_cache",
        ["group_name", "schedule_date"],
    )


def downgrade():
    op.drop_index("idx_schedule_cache_group_date", table_name="schedule_cache")
    op.drop_index("idx_schedule_group_date", table_name="schedule")
    op.drop_index("idx_subjects_teacher_id", table_name="subjects")
    op.drop_index("idx_students_group_id", table_name="students")
    op.drop_index("idx_students_user_id", table_name="students")
    op.drop_index("idx_users_auth_id", table_name="users")
    op.drop_table("schedule_cache")
    op.drop_table("notifications")
    op.drop_table("event_participation")
    op.drop_table("events")
    op.drop_table("group_statement")
    op.drop_table("work")
    op.drop_table("testassignments")
    op.drop_table("assignments")
    op.drop_table("student_works")
    op.drop_table("student_performance")
    op.drop_table("student_subject_grades")
    op.drop_table("class_sessions")
    op.drop_table("schedule")
    op.drop_table("subject_groups")
    op.drop_table("subjects")
    op.drop_table("teachers")
    op.drop_table("students")
    op.drop_table("groups")
    op.drop_table("users")
