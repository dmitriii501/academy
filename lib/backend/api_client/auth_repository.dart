import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_client.dart';

class AuthRepository {
  AuthRepository._();

  static final AuthRepository instance = AuthRepository._();

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _authIdKey = 'auth_id';
  static const _userIdKey = 'user_id';
  static const _isTeacherKey = 'is_teacher';
  static const _superuserKey = 'superuser';

  final _controller = StreamController<AuthSession>.broadcast();

  AuthSession? _session;

  Stream<AuthSession> get sessionStream => _controller.stream;

  AuthSession? get current => _session;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final access = prefs.getString(_accessTokenKey);
    final refresh = prefs.getString(_refreshTokenKey);
    final authId = prefs.getString(_authIdKey);
    final userId = prefs.getInt(_userIdKey);
    final isTeacher = prefs.getBool(_isTeacherKey) ?? false;
    final superuser = prefs.getBool(_superuserKey) ?? false;
    if (access != null && authId != null && userId != null) {
      _session = AuthSession(
        accessToken: access,
        refreshToken: refresh ?? '',
        authId: authId,
        userId: userId,
        isTeacher: isTeacher,
        superuser: superuser,
      );
      ApiClient.instance.setAccessToken(access);
      _controller.add(_session!);
    }
  }

  Future<AuthSession> login(String login, String password) async {
    final response = await ApiClient.instance.post(
      '/auth/login',
      body: {
        'login': login,
        'password': password,
      },
    );
    final session = AuthSession.fromMap(response);
    await _persist(session);
    return session;
  }

  Future<AuthSession> register(
    String fullName,
    String email,
    String password,
    String role,
    String? groupName,
  ) async {
    final response = await ApiClient.instance.post(
      '/auth/register',
      body: {
        'full_name': fullName,
        'email': email,
        'password': password,
        'role': role,
        if (groupName != null) 'group_name': groupName,
      },
    );
    final session = AuthSession.fromMap(response);
    await _persist(session);
    return session;
  }

  Future<void> logout() async {
    _session = null;
    ApiClient.instance.setAccessToken(null);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
    await prefs.remove(_authIdKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_isTeacherKey);
    await prefs.remove(_superuserKey);
    _controller.add(AuthSession.empty());
  }

  Future<void> _persist(AuthSession session) async {
    _session = session;
    ApiClient.instance.setAccessToken(session.accessToken);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, session.accessToken);
    await prefs.setString(_refreshTokenKey, session.refreshToken);
    await prefs.setString(_authIdKey, session.authId);
    await prefs.setInt(_userIdKey, session.userId);
    await prefs.setBool(_isTeacherKey, session.isTeacher);
    await prefs.setBool(_superuserKey, session.superuser);
    _controller.add(session);
  }
}

class AuthSession {
  AuthSession({
    required this.accessToken,
    required this.refreshToken,
    required this.authId,
    required this.userId,
    required this.isTeacher,
    required this.superuser,
  });

  final String accessToken;
  final String refreshToken;
  final String authId;
  final int userId;
  final bool isTeacher;
  final bool superuser;

  factory AuthSession.fromMap(Map<String, dynamic> map) => AuthSession(
        accessToken: map['access_token'] as String,
        refreshToken: map['refresh_token'] as String? ?? '',
        authId: map['auth_id'] as String,
        userId: map['user_id'] as int,
        isTeacher: map['is_teacher'] as bool? ?? false,
        superuser: map['superuser'] as bool? ?? false,
      );

  static AuthSession empty() => AuthSession(
        accessToken: '',
        refreshToken: '',
        authId: '',
        userId: 0,
        isTeacher: false,
        superuser: false,
      );
}
