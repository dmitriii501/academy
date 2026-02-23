import '../database.dart';

class Update3Table extends SupabaseTable<Update3Row> {
  @override
  String get tableName => 'update3';

  @override
  Update3Row createRow(Map<String, dynamic> data) => Update3Row(data);
}

class Update3Row extends SupabaseDataRow {
  Update3Row(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => Update3Table();

  int get update => getField<int>('update')!;
  set update(int value) => setField<int>('update', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);
}
