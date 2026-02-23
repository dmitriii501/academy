import '../database.dart';

class StudentSubjectGradesTable extends SupabaseTable<StudentSubjectGradesRow> {
  @override
  String get tableName => 'student_subject_grades';

  @override
  StudentSubjectGradesRow createRow(Map<String, dynamic> data) =>
      StudentSubjectGradesRow(data);
}

class StudentSubjectGradesRow extends SupabaseDataRow {
  StudentSubjectGradesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => StudentSubjectGradesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int get studentId => getField<int>('student_id')!;
  set studentId(int value) => setField<int>('student_id', value);

  int get subjectId => getField<int>('subject_id')!;
  set subjectId(int value) => setField<int>('subject_id', value);

  double? get finalExamGrade => getField<double>('final_exam_grade');
  set finalExamGrade(double? value) =>
      setField<double>('final_exam_grade', value);

  String? get studentName => getField<String>('student_name');
  set studentName(String? value) => setField<String>('student_name', value);

  int? get group => getField<int>('group');
  set group(int? value) => setField<int>('group', value);

  bool? get seminarAttended => getField<bool>('seminar_attended');
  set seminarAttended(bool? value) => setField<bool>('seminar_attended', value);

  DateTime? get date => getField<DateTime>('date');
  set date(DateTime? value) => setField<DateTime>('date', value);

  int? get semGrade => getField<int>('sem_grade');
  set semGrade(int? value) => setField<int>('sem_grade', value);

  int? get finalGrade => getField<int>('final_grade');
  set finalGrade(int? value) => setField<int>('final_grade', value);
}
