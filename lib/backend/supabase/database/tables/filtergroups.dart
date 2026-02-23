import '../database.dart';

class FiltergroupsTable extends SupabaseTable<FiltergroupsRow> {
  @override
  String get tableName => 'filtergroups';

  @override
  FiltergroupsRow createRow(Map<String, dynamic> data) => FiltergroupsRow(data);
}

class FiltergroupsRow extends SupabaseDataRow {
  FiltergroupsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => FiltergroupsTable();

  int get fil => getField<int>('fil')!;
  set fil(int value) => setField<int>('fil', value);

  String get groups => getField<String>('groups')!;
  set groups(String value) => setField<String>('groups', value);

  String? get subjects => getField<String>('subjects');
  set subjects(String? value) => setField<String>('subjects', value);

  String? get work => getField<String>('work');
  set work(String? value) => setField<String>('work', value);
}
