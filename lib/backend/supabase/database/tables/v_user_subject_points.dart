import '../database.dart';

class VUserSubjectPointsTable extends SupabaseTable<VUserSubjectPointsRow> {
  @override
  String get tableName => 'v_user_subject_points';

  @override
  VUserSubjectPointsRow createRow(Map<String, dynamic> data) =>
      VUserSubjectPointsRow(data);
}

class VUserSubjectPointsRow extends SupabaseDataRow {
  VUserSubjectPointsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => VUserSubjectPointsTable();

  int? get userId => getField<int>('user_id');
  set userId(int? value) => setField<int>('user_id', value);

  int? get subjectId => getField<int>('subject_id');
  set subjectId(int? value) => setField<int>('subject_id', value);

  int? get eventPoints => getField<int>('event_points');
  set eventPoints(int? value) => setField<int>('event_points', value);

  int? get assignmentPoints => getField<int>('assignment_points');
  set assignmentPoints(int? value) => setField<int>('assignment_points', value);

  int? get totalPoints => getField<int>('total_points');
  set totalPoints(int? value) => setField<int>('total_points', value);
}
