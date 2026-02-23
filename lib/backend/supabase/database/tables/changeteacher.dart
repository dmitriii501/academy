import '../database.dart';

class ChangeteacherTable extends SupabaseTable<ChangeteacherRow> {
  @override
  String get tableName => 'changeteacher';

  @override
  ChangeteacherRow createRow(Map<String, dynamic> data) =>
      ChangeteacherRow(data);
}

class ChangeteacherRow extends SupabaseDataRow {
  ChangeteacherRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ChangeteacherTable();

  int get change => getField<int>('change')!;
  set change(int value) => setField<int>('change', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);
}
