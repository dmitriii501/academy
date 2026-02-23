import '../database.dart';

class StudentsTable extends SupabaseTable<StudentsRow> {
  @override
  String get tableName => 'students';

  @override
  StudentsRow createRow(Map<String, dynamic> data) => StudentsRow(data);
}

class StudentsRow extends SupabaseDataRow {
  StudentsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => StudentsTable();

  int get studentId => getField<int>('student_id')!;
  set studentId(int value) => setField<int>('student_id', value);

  int get userId => getField<int>('user_id')!;
  set userId(int value) => setField<int>('user_id', value);

  String? get course => getField<String>('course');
  set course(String? value) => setField<String>('course', value);

  int? get groupId => getField<int>('group_id');
  set groupId(int? value) => setField<int>('group_id', value);

  String? get formStudy => getField<String>('form_study');
  set formStudy(String? value) => setField<String>('form_study', value);

  DateTime? get birthDate => getField<DateTime>('birth_date');
  set birthDate(DateTime? value) => setField<DateTime>('birth_date', value);

  String? get birthPlace => getField<String>('birth_place');
  set birthPlace(String? value) => setField<String>('birth_place', value);

  String? get birthCountry => getField<String>('birth_country');
  set birthCountry(String? value) => setField<String>('birth_country', value);

  double? get averagePerformance5 => getField<double>('average_performance_5');
  set averagePerformance5(double? value) =>
      setField<double>('average_performance_5', value);

  int? get number => getField<int>('number');
  set number(int? value) => setField<int>('number', value);
}
