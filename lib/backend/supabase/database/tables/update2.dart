import '../database.dart';

class Update2Table extends SupabaseTable<Update2Row> {
  @override
  String get tableName => 'update2';

  @override
  Update2Row createRow(Map<String, dynamic> data) => Update2Row(data);
}

class Update2Row extends SupabaseDataRow {
  Update2Row(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => Update2Table();

  int get update => getField<int>('update')!;
  set update(int value) => setField<int>('update', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);
}
