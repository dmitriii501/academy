import '../database.dart';

class FilterdevelopmentTable extends SupabaseTable<FilterdevelopmentRow> {
  @override
  String get tableName => 'filterdevelopment';

  @override
  FilterdevelopmentRow createRow(Map<String, dynamic> data) =>
      FilterdevelopmentRow(data);
}

class FilterdevelopmentRow extends SupabaseDataRow {
  FilterdevelopmentRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => FilterdevelopmentTable();

  int get filter => getField<int>('filter')!;
  set filter(int value) => setField<int>('filter', value);

  String get finance => getField<String>('finance')!;
  set finance(String value) => setField<String>('finance', value);

  String? get rec => getField<String>('rec');
  set rec(String? value) => setField<String>('rec', value);

  String? get dyx => getField<String>('dyx');
  set dyx(String? value) => setField<String>('dyx', value);

  String? get top => getField<String>('top');
  set top(String? value) => setField<String>('top', value);

  String? get tema => getField<String>('tema');
  set tema(String? value) => setField<String>('tema', value);

  String? get userD => getField<String>('userD');
  set userD(String? value) => setField<String>('userD', value);
}
