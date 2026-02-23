import '/backend/api_client/auth_repository.dart';

Future<AuthSession?> emailSignInFunc(
  String email,
  String password,
) async {
  return AuthRepository.instance.login(email, password);
}

Future<AuthSession?> emailCreateAccountFunc(
  String email,
  String password,
) async {
  return AuthRepository.instance.register(
    email,
    email,
    password,
    'student',
    null,
  );
}
