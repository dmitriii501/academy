import '../database.dart';

class SubjectTopicsTable extends SupabaseTable<SubjectTopicsRow> {
  @override
  String get tableName => 'subject_topics';

  @override
  SubjectTopicsRow createRow(Map<String, dynamic> data) =>
      SubjectTopicsRow(data);
}

class SubjectTopicsRow extends SupabaseDataRow {
  SubjectTopicsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => SubjectTopicsTable();

  int get topicId => getField<int>('topic_id')!;
  set topicId(int value) => setField<int>('topic_id', value);

  int get subjectId => getField<int>('subject_id')!;
  set subjectId(int value) => setField<int>('subject_id', value);

  String get topic => getField<String>('topic')!;
  set topic(String value) => setField<String>('topic', value);
}
