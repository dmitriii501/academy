import '../database.dart';

class RecommendationsTable extends SupabaseTable<RecommendationsRow> {
  @override
  String get tableName => 'recommendations';

  @override
  RecommendationsRow createRow(Map<String, dynamic> data) =>
      RecommendationsRow(data);
}

class RecommendationsRow extends SupabaseDataRow {
  RecommendationsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RecommendationsTable();

  int get rec => getField<int>('rec')!;
  set rec(int value) => setField<int>('rec', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);
}
