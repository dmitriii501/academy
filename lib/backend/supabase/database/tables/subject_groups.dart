import '../database.dart';

class SubjectGroupsTable extends SupabaseTable<SubjectGroupsRow> {
  @override
  String get tableName => 'subject_groups';

  @override
  SubjectGroupsRow createRow(Map<String, dynamic> data) =>
      SubjectGroupsRow(data);
}

class SubjectGroupsRow extends SupabaseDataRow {
  SubjectGroupsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => SubjectGroupsTable();

  int get subjectId => getField<int>('subject_id')!;
  set subjectId(int value) => setField<int>('subject_id', value);

  int get groupId => getField<int>('group_id')!;
  set groupId(int value) => setField<int>('group_id', value);

  String get examType => getField<String>('exam_type')!;
  set examType(String value) => setField<String>('exam_type', value);
}
