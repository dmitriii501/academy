import '../database.dart';

class AssignmentsTable extends SupabaseTable<AssignmentsRow> {
  @override
  String get tableName => 'assignments';

  @override
  AssignmentsRow createRow(Map<String, dynamic> data) => AssignmentsRow(data);
}

class AssignmentsRow extends SupabaseDataRow {
  AssignmentsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AssignmentsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  int? get topicId => getField<int>('topic_id');
  set topicId(int? value) => setField<int>('topic_id', value);

  String? get fileUrl => getField<String>('file_url');
  set fileUrl(String? value) => setField<String>('file_url', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  int? get userTableId => getField<int>('userTableId');
  set userTableId(int? value) => setField<int>('userTableId', value);

  int? get grade => getField<int>('grade');
  set grade(int? value) => setField<int>('grade', value);

  String? get teacherComment => getField<String>('teacherComment');
  set teacherComment(String? value) =>
      setField<String>('teacherComment', value);

  String? get typeOfWork => getField<String>('typeOfWork');
  set typeOfWork(String? value) => setField<String>('typeOfWork', value);

  String? get typeOFWorkSecond => getField<String>('typeOFWorkSecond');
  set typeOFWorkSecond(String? value) =>
      setField<String>('typeOFWorkSecond', value);

  bool? get isChecked => getField<bool>('is_checked');
  set isChecked(bool? value) => setField<bool>('is_checked', value);

  String? get nameStudent => getField<String>('nameStudent');
  set nameStudent(String? value) => setField<String>('nameStudent', value);

  bool? get isdelivered => getField<bool>('isdelivered');
  set isdelivered(bool? value) => setField<bool>('isdelivered', value);

  bool? get isDebt => getField<bool>('is_debt');
  set isDebt(bool? value) => setField<bool>('is_debt', value);

  bool? get isReferat => getField<bool>('is_referat');
  set isReferat(bool? value) => setField<bool>('is_referat', value);

  int? get subjectId => getField<int>('subject_id');
  set subjectId(int? value) => setField<int>('subject_id', value);
}
