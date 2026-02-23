import '../database.dart';

class SpirituallyTable extends SupabaseTable<SpirituallyRow> {
  @override
  String get tableName => 'spiritually';

  @override
  SpirituallyRow createRow(Map<String, dynamic> data) => SpirituallyRow(data);
}

class SpirituallyRow extends SupabaseDataRow {
  SpirituallyRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => SpirituallyTable();

  int get dyx => getField<int>('dyx')!;
  set dyx(int value) => setField<int>('dyx', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);
}
