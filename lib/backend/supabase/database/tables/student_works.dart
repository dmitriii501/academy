import '../database.dart';

class StudentWorksTable extends SupabaseTable<StudentWorksRow> {
  @override
  String get tableName => 'student_works';

  @override
  StudentWorksRow createRow(Map<String, dynamic> data) => StudentWorksRow(data);
}

class StudentWorksRow extends SupabaseDataRow {
  StudentWorksRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => StudentWorksTable();

  int get workId => getField<int>('work_id')!;
  set workId(int value) => setField<int>('work_id', value);

  int get studentId => getField<int>('student_id')!;
  set studentId(int value) => setField<int>('student_id', value);

  int get subjectId => getField<int>('subject_id')!;
  set subjectId(int value) => setField<int>('subject_id', value);

  String? get workType => getField<String>('work_type');
  set workType(String? value) => setField<String>('work_type', value);

  String? get classification => getField<String>('classification');
  set classification(String? value) =>
      setField<String>('classification', value);

  String? get topic => getField<String>('topic');
  set topic(String? value) => setField<String>('topic', value);

  DateTime? get assignedDate => getField<DateTime>('assigned_date');
  set assignedDate(DateTime? value) =>
      setField<DateTime>('assigned_date', value);

  DateTime? get submittedDate => getField<DateTime>('submitted_date');
  set submittedDate(DateTime? value) =>
      setField<DateTime>('submitted_date', value);

  String? get linkToWork => getField<String>('link_to_work');
  set linkToWork(String? value) => setField<String>('link_to_work', value);

  String? get teacherComment => getField<String>('teacher_comment');
  set teacherComment(String? value) =>
      setField<String>('teacher_comment', value);

  double? get points => getField<double>('points');
  set points(double? value) => setField<double>('points', value);

  bool get checked => getField<bool>('checked')!;
  set checked(bool value) => setField<bool>('checked', value);

  DateTime? get checkedDate => getField<DateTime>('checked_date');
  set checkedDate(DateTime? value) => setField<DateTime>('checked_date', value);
}
