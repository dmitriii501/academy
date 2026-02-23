import '../database.dart';

class TopTable extends SupabaseTable<TopRow> {
  @override
  String get tableName => 'top';

  @override
  TopRow createRow(Map<String, dynamic> data) => TopRow(data);
}

class TopRow extends SupabaseDataRow {
  TopRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TopTable();

  int get topp => getField<int>('topp')!;
  set topp(int value) => setField<int>('topp', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);
}
