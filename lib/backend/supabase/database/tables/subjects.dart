import '../database.dart';

class SubjectsTable extends SupabaseTable<SubjectsRow> {
  @override
  String get tableName => 'subjects';

  @override
  SubjectsRow createRow(Map<String, dynamic> data) => SubjectsRow(data);
}

class SubjectsRow extends SupabaseDataRow {
  SubjectsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => SubjectsTable();

  int get subjectId => getField<int>('subject_id')!;
  set subjectId(int value) => setField<int>('subject_id', value);

  String get subjectName => getField<String>('subject_name')!;
  set subjectName(String value) => setField<String>('subject_name', value);

  int? get totalHours => getField<int>('total_hours');
  set totalHours(int? value) => setField<int>('total_hours', value);

  String? get color => getField<String>('color');
  set color(String? value) => setField<String>('color', value);

  int get teacherId => getField<int>('teacher_id')!;
  set teacherId(int value) => setField<int>('teacher_id', value);

  String? get typeOfSubject => getField<String>('type_of_subject');
  set typeOfSubject(String? value) =>
      setField<String>('type_of_subject', value);

  String? get fullName => getField<String>('full_name');
  set fullName(String? value) => setField<String>('full_name', value);

  int? get groupId => getField<int>('group_id');
  set groupId(int? value) => setField<int>('group_id', value);
}
