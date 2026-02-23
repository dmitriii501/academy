import '../database.dart';

class CurrentDateTableTable extends SupabaseTable<CurrentDateTableRow> {
  @override
  String get tableName => 'current_date_table';

  @override
  CurrentDateTableRow createRow(Map<String, dynamic> data) =>
      CurrentDateTableRow(data);
}

class CurrentDateTableRow extends SupabaseDataRow {
  CurrentDateTableRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => CurrentDateTableTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get currentDay => getField<DateTime>('current_day')!;
  set currentDay(DateTime value) => setField<DateTime>('current_day', value);
}
