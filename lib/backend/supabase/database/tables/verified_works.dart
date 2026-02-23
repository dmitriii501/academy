import '../database.dart';

class VerifiedWorksTable extends SupabaseTable<VerifiedWorksRow> {
  @override
  String get tableName => 'verified_works';

  @override
  VerifiedWorksRow createRow(Map<String, dynamic> data) =>
      VerifiedWorksRow(data);
}

class VerifiedWorksRow extends SupabaseDataRow {
  VerifiedWorksRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => VerifiedWorksTable();

  int get work => getField<int>('work')!;
  set work(int value) => setField<int>('work', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);
}
