import '../database.dart';

class FilterteacherTable extends SupabaseTable<FilterteacherRow> {
  @override
  String get tableName => 'filterteacher';

  @override
  FilterteacherRow createRow(Map<String, dynamic> data) =>
      FilterteacherRow(data);
}

class FilterteacherRow extends SupabaseDataRow {
  FilterteacherRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => FilterteacherTable();

  int get work => getField<int>('work')!;
  set work(int value) => setField<int>('work', value);

  String get change => getField<String>('change')!;
  set change(String value) => setField<String>('change', value);

  String? get update1 => getField<String>('update1');
  set update1(String? value) => setField<String>('update1', value);

  String? get update2 => getField<String>('update2');
  set update2(String? value) => setField<String>('update2', value);

  String? get update3 => getField<String>('update3');
  set update3(String? value) => setField<String>('update3', value);

  String? get workk => getField<String>('workk');
  set workk(String? value) => setField<String>('workk', value);

  String? get userD => getField<String>('userD');
  set userD(String? value) => setField<String>('userD', value);
}
