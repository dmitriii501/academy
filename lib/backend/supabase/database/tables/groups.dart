import '../database.dart';

class GroupsTable extends SupabaseTable<GroupsRow> {
  @override
  String get tableName => 'groups';

  @override
  GroupsRow createRow(Map<String, dynamic> data) => GroupsRow(data);
}

class GroupsRow extends SupabaseDataRow {
  GroupsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => GroupsTable();

  int get groupId => getField<int>('group_id')!;
  set groupId(int value) => setField<int>('group_id', value);

  String get groupName => getField<String>('group_name')!;
  set groupName(String value) => setField<String>('group_name', value);
}
