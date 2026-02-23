import '../database.dart';

class ChangeTable extends SupabaseTable<ChangeRow> {
  @override
  String get tableName => 'change';

  @override
  ChangeRow createRow(Map<String, dynamic> data) => ChangeRow(data);
}

class ChangeRow extends SupabaseDataRow {
  ChangeRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ChangeTable();

  int get chang => getField<int>('chang')!;
  set chang(int value) => setField<int>('chang', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);
}
