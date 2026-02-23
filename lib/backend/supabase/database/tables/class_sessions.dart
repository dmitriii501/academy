import '../database.dart';

class ClassSessionsTable extends SupabaseTable<ClassSessionsRow> {
  @override
  String get tableName => 'class_sessions';

  @override
  ClassSessionsRow createRow(Map<String, dynamic> data) =>
      ClassSessionsRow(data);
}

class ClassSessionsRow extends SupabaseDataRow {
  ClassSessionsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ClassSessionsTable();

  int get sessionId => getField<int>('session_id')!;
  set sessionId(int value) => setField<int>('session_id', value);

  int get subjectId => getField<int>('subject_id')!;
  set subjectId(int value) => setField<int>('subject_id', value);

  int get groupId => getField<int>('group_id')!;
  set groupId(int value) => setField<int>('group_id', value);

  int get teacherId => getField<int>('teacher_id')!;
  set teacherId(int value) => setField<int>('teacher_id', value);

  DateTime get sessionDate => getField<DateTime>('session_date')!;
  set sessionDate(DateTime value) => setField<DateTime>('session_date', value);

  String? get sessionType => getField<String>('session_type');
  set sessionType(String? value) => setField<String>('session_type', value);

  PostgresTime get startTime => getField<PostgresTime>('start_time')!;
  set startTime(PostgresTime value) =>
      setField<PostgresTime>('start_time', value);

  PostgresTime get endTime => getField<PostgresTime>('end_time')!;
  set endTime(PostgresTime value) => setField<PostgresTime>('end_time', value);

  String? get classroom => getField<String>('classroom');
  set classroom(String? value) => setField<String>('classroom', value);
}
