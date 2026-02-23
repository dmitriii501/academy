import '../database.dart';

class UsersTable extends SupabaseTable<UsersRow> {
  @override
  String get tableName => 'users';

  @override
  UsersRow createRow(Map<String, dynamic> data) => UsersRow(data);
}

class UsersRow extends SupabaseDataRow {
  UsersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UsersTable();

  int get userId => getField<int>('user_id')!;
  set userId(int value) => setField<int>('user_id', value);

  String get fullName => getField<String>('full_name')!;
  set fullName(String value) => setField<String>('full_name', value);

  String? get corporateEmail => getField<String>('corporate_email');
  set corporateEmail(String? value) =>
      setField<String>('corporate_email', value);

  String? get personalEmail => getField<String>('personal_email');
  set personalEmail(String? value) => setField<String>('personal_email', value);

  String? get phone => getField<String>('phone');
  set phone(String? value) => setField<String>('phone', value);

  String? get photoUrl => getField<String>('photo_url');
  set photoUrl(String? value) => setField<String>('photo_url', value);

  String? get authId => getField<String>('auth_id');
  set authId(String? value) => setField<String>('auth_id', value);

  bool? get isTeacher => getField<bool>('is_teacher');
  set isTeacher(bool? value) => setField<bool>('is_teacher', value);

  bool? get superuser => getField<bool>('superuser');
  set superuser(bool? value) => setField<bool>('superuser', value);
}
