import '/backend/supabase/supabase.dart';

class UserRepository {
  UserRepository._();

  static final UserRepository instance = UserRepository._();

  String? _cachedGroupName;
  String? _cachedAuthId;

  Future<String> getStudentGroupName(String authId) async {
    if (_cachedGroupName != null && _cachedAuthId == authId) {
      return _cachedGroupName!;
    }
    final userRows = await UsersTable().queryRows(
      queryFn: (q) => q.eqOrNull('auth_id', authId),
      limit: 1,
    );
    final userId = userRows.firstOrNull?.userId;
    if (userId == null) {
      return '';
    }
    final studentRows = await StudentsTable().queryRows(
      queryFn: (q) => q.eqOrNull('user_id', userId),
      limit: 1,
    );
    final groupId = studentRows.firstOrNull?.groupId;
    if (groupId == null) {
      return '';
    }
    final groupRows = await GroupsTable().queryRows(
      queryFn: (q) => q.eqOrNull('group_id', groupId),
      limit: 1,
    );
    final groupName = groupRows.firstOrNull?.groupName ?? '';
    _cachedGroupName = groupName;
    _cachedAuthId = authId;
    return groupName;
  }
}
