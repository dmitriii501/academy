import '../database.dart';

class Update1Table extends SupabaseTable<Update1Row> {
  @override
  String get tableName => 'update1';

  @override
  Update1Row createRow(Map<String, dynamic> data) => Update1Row(data);
}

class Update1Row extends SupabaseDataRow {
  Update1Row(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => Update1Table();

  int get change => getField<int>('change')!;
  set change(int value) => setField<int>('change', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);
}
