import '../database.dart';

class GroupStatementTable extends SupabaseTable<GroupStatementRow> {
  @override
  String get tableName => 'group_statement';

  @override
  GroupStatementRow createRow(Map<String, dynamic> data) =>
      GroupStatementRow(data);
}

class GroupStatementRow extends SupabaseDataRow {
  GroupStatementRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => GroupStatementTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int get userId => getField<int>('user_id')!;
  set userId(int value) => setField<int>('user_id', value);

  int get subjectId => getField<int>('subject_id')!;
  set subjectId(int value) => setField<int>('subject_id', value);

  int? get eventPoints => getField<int>('event_points');
  set eventPoints(int? value) => setField<int>('event_points', value);

  int? get assignmentPoints => getField<int>('assignment_points');
  set assignmentPoints(int? value) => setField<int>('assignment_points', value);

  int? get totalPoints => getField<int>('total_points');
  set totalPoints(int? value) => setField<int>('total_points', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');
  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);

  int? get groupid => getField<int>('groupid');
  set groupid(int? value) => setField<int>('groupid', value);

  bool? get isAttended => getField<bool>('isAttended');
  set isAttended(bool? value) => setField<bool>('isAttended', value);

  int? get attendedPoints => getField<int>('attended_points');
  set attendedPoints(int? value) => setField<int>('attended_points', value);

  int? get exampoint => getField<int>('exampoint');
  set exampoint(int? value) => setField<int>('exampoint', value);

  int? get pointsOfWorking => getField<int>('pointsOfWorking');
  set pointsOfWorking(int? value) => setField<int>('pointsOfWorking', value);

  String? get reasonOfPass => getField<String>('reasonOfPass');
  set reasonOfPass(String? value) => setField<String>('reasonOfPass', value);

  bool? get isLecture => getField<bool>('IsLecture');
  set isLecture(bool? value) => setField<bool>('IsLecture', value);
}
