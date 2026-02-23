import '../database.dart';

class UpdateTable extends SupabaseTable<UpdateRow> {
  @override
  String get tableName => 'update';

  @override
  UpdateRow createRow(Map<String, dynamic> data) => UpdateRow(data);
}

class UpdateRow extends SupabaseDataRow {
  UpdateRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UpdateTable();

  int get updat => getField<int>('updat')!;
  set updat(int value) => setField<int>('updat', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);
}
