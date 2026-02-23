import '../database.dart';

class FinanceTable extends SupabaseTable<FinanceRow> {
  @override
  String get tableName => 'finance';

  @override
  FinanceRow createRow(Map<String, dynamic> data) => FinanceRow(data);
}

class FinanceRow extends SupabaseDataRow {
  FinanceRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => FinanceTable();

  int get financee => getField<int>('financee')!;
  set financee(int value) => setField<int>('financee', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);
}
