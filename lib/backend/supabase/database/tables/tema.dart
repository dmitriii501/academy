import '../database.dart';

class TemaTable extends SupabaseTable<TemaRow> {
  @override
  String get tableName => 'tema';

  @override
  TemaRow createRow(Map<String, dynamic> data) => TemaRow(data);
}

class TemaRow extends SupabaseDataRow {
  TemaRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TemaTable();

  int get tema => getField<int>('temaф')!;
  set tema(int value) => setField<int>('temaф', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);
}
