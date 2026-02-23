import '../database.dart';

class ResourcesTable extends SupabaseTable<ResourcesRow> {
  @override
  String get tableName => 'resources';

  @override
  ResourcesRow createRow(Map<String, dynamic> data) => ResourcesRow(data);
}

class ResourcesRow extends SupabaseDataRow {
  ResourcesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ResourcesTable();

  int get resourceId => getField<int>('resource_id')!;
  set resourceId(int value) => setField<int>('resource_id', value);

  String get resourceType => getField<String>('resource_type')!;
  set resourceType(String value) => setField<String>('resource_type', value);

  String get title => getField<String>('title')!;
  set title(String value) => setField<String>('title', value);

  String? get imageUrl => getField<String>('image_url');
  set imageUrl(String? value) => setField<String>('image_url', value);

  String? get releaseDate => getField<String>('release_date');
  set releaseDate(String? value) => setField<String>('release_date', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  String? get link => getField<String>('link');
  set link(String? value) => setField<String>('link', value);

  String? get author => getField<String>('author');
  set author(String? value) => setField<String>('author', value);
}
