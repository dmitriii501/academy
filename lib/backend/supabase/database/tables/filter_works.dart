import '../database.dart';

class FilterWorksTable extends SupabaseTable<FilterWorksRow> {
  @override
  String get tableName => 'filter_works';

  @override
  FilterWorksRow createRow(Map<String, dynamic> data) => FilterWorksRow(data);
}

class FilterWorksRow extends SupabaseDataRow {
  FilterWorksRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => FilterWorksTable();

  int get filterId => getField<int>('filter_id')!;
  set filterId(int value) => setField<int>('filter_id', value);

  String get groupFilter => getField<String>('group_filter')!;
  set groupFilter(String value) => setField<String>('group_filter', value);

  String get subjectFilter => getField<String>('subject_filter')!;
  set subjectFilter(String value) => setField<String>('subject_filter', value);

  String get workType => getField<String>('work_type')!;
  set workType(String value) => setField<String>('work_type', value);

  DateTime get filterDate => getField<DateTime>('filter_date')!;
  set filterDate(DateTime value) => setField<DateTime>('filter_date', value);

  String? get userD => getField<String>('userD');
  set userD(String? value) => setField<String>('userD', value);
}
