import '../database.dart';

class FiltnotTable extends SupabaseTable<FiltnotRow> {
  @override
  String get tableName => 'filtnot';

  @override
  FiltnotRow createRow(Map<String, dynamic> data) => FiltnotRow(data);
}

class FiltnotRow extends SupabaseDataRow {
  FiltnotRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => FiltnotTable();

  String get work => getField<String>('work')!;
  set work(String value) => setField<String>('work', value);

  String get change => getField<String>('change')!;
  set change(String value) => setField<String>('change', value);

  String? get update => getField<String>('update');
  set update(String? value) => setField<String>('update', value);

  String? get userD => getField<String>('userD');
  set userD(String? value) => setField<String>('userD', value);
}
