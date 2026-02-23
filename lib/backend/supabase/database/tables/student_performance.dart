import '../database.dart';

class StudentPerformanceTable extends SupabaseTable<StudentPerformanceRow> {
  @override
  String get tableName => 'student_performance';

  @override
  StudentPerformanceRow createRow(Map<String, dynamic> data) =>
      StudentPerformanceRow(data);
}

class StudentPerformanceRow extends SupabaseDataRow {
  StudentPerformanceRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => StudentPerformanceTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int get groupId => getField<int>('group_id')!;
  set groupId(int value) => setField<int>('group_id', value);

  int get studentId => getField<int>('student_id')!;
  set studentId(int value) => setField<int>('student_id', value);

  int get subjectId => getField<int>('subject_id')!;
  set subjectId(int value) => setField<int>('subject_id', value);

  int? get idOfGroupStatement => getField<int>('id_of_group_statement');
  set idOfGroupStatement(int? value) =>
      setField<int>('id_of_group_statement', value);

  DateTime get date => getField<DateTime>('date')!;
  set date(DateTime value) => setField<DateTime>('date', value);

  int get pointsOfWork => getField<int>('points_of_work')!;
  set pointsOfWork(int value) => setField<int>('points_of_work', value);

  bool get isAttended => getField<bool>('is_attended')!;
  set isAttended(bool value) => setField<bool>('is_attended', value);

  int get pointsOfAttended => getField<int>('points_of_attended')!;
  set pointsOfAttended(int value) => setField<int>('points_of_attended', value);

  String? get reasonOfPass => getField<String>('reason_of_pass');
  set reasonOfPass(String? value) => setField<String>('reason_of_pass', value);
}
