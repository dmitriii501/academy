import '../database.dart';

class TeachersTable extends SupabaseTable<TeachersRow> {
  @override
  String get tableName => 'teachers';

  @override
  TeachersRow createRow(Map<String, dynamic> data) => TeachersRow(data);
}

class TeachersRow extends SupabaseDataRow {
  TeachersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TeachersTable();

  int get teacherId => getField<int>('teacher_id')!;
  set teacherId(int value) => setField<int>('teacher_id', value);

  int get userId => getField<int>('user_id')!;
  set userId(int value) => setField<int>('user_id', value);

  String? get department => getField<String>('department');
  set department(String? value) => setField<String>('department', value);

  DateTime? get birthDate => getField<DateTime>('birthDate');
  set birthDate(DateTime? value) => setField<DateTime>('birthDate', value);

  String? get place => getField<String>('place');
  set place(String? value) => setField<String>('place', value);

  String? get country => getField<String>('country');
  set country(String? value) => setField<String>('country', value);
}
