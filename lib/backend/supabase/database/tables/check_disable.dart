import '../database.dart';

class CheckDisableTable extends SupabaseTable<CheckDisableRow> {
  @override
  String get tableName => 'check-disable';

  @override
  CheckDisableRow createRow(Map<String, dynamic> data) => CheckDisableRow(data);
}

class CheckDisableRow extends SupabaseDataRow {
  CheckDisableRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => CheckDisableTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  bool get check => getField<bool>('check')!;
  set check(bool value) => setField<bool>('check', value);
}
