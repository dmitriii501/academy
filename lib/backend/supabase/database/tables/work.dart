import '../database.dart';

class WorkTable extends SupabaseTable<WorkRow> {
  @override
  String get tableName => 'work';

  @override
  WorkRow createRow(Map<String, dynamic> data) => WorkRow(data);
}

class WorkRow extends SupabaseDataRow {
  WorkRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => WorkTable();

  int get workk => getField<int>('workk')!;
  set workk(int value) => setField<int>('workk', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);
}
