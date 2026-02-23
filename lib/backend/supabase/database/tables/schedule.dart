import '../database.dart';

class ScheduleTable extends SupabaseTable<ScheduleRow> {
  @override
  String get tableName => 'schedule';

  @override
  ScheduleRow createRow(Map<String, dynamic> data) => ScheduleRow(data);
}

class ScheduleRow extends SupabaseDataRow {
  ScheduleRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ScheduleTable();

  int get scheduleId => getField<int>('schedule_id')!;
  set scheduleId(int value) => setField<int>('schedule_id', value);

  int get groupId => getField<int>('group_id')!;
  set groupId(int value) => setField<int>('group_id', value);

  int get subjectId => getField<int>('subject_id')!;
  set subjectId(int value) => setField<int>('subject_id', value);

  int get teacherId => getField<int>('teacher_id')!;
  set teacherId(int value) => setField<int>('teacher_id', value);

  DateTime get scheduleDate => getField<DateTime>('schedule_date')!;
  set scheduleDate(DateTime value) =>
      setField<DateTime>('schedule_date', value);

  String get startTimeEndTime => getField<String>('start_time-end_time')!;
  set startTimeEndTime(String value) =>
      setField<String>('start_time-end_time', value);

  String? get classType => getField<String>('class_type');
  set classType(String? value) => setField<String>('class_type', value);

  String? get classroom => getField<String>('classroom');
  set classroom(String? value) => setField<String>('classroom', value);
}
