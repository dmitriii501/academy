import 'package:rxdart/rxdart.dart';

import '/backend/api_client/auth_repository.dart';
import '../base_auth_user_provider.dart';

export '../base_auth_user_provider.dart';

class PrototypeAppSupabaseUser extends BaseAuthUser {
  PrototypeAppSupabaseUser(this.session);
  final AuthSession? session;
  bool get loggedIn => session != null && session!.accessToken.isNotEmpty;

  @override
  AuthUserInfo get authUserInfo => AuthUserInfo(
        uid: session?.authId,
        email: null,
        phoneNumber: null,
      );

  @override
  Future? delete() =>
      throw UnsupportedError('The delete user operation is not yet supported.');

  @override
  Future? updateEmail(String email) async {
    throw UnsupportedError('Update email is not implemented for local auth.');
  }

  @override
  Future? updatePassword(String newPassword) async {
    throw UnsupportedError('Update password is not implemented for local auth.');
  }

  @override
  Future? sendEmailVerification() => throw UnsupportedError(
      'The send email verification operation is not yet supported.');

  @override
  bool get emailVerified => true;

  @override
  Future refreshUser() async {}
}

/// Generates a stream of the authenticated user.
/// [SupaFlow.client.auth.onAuthStateChange] does not yield any values until the
/// user is already authenticated. So we add a default null user to the stream,
/// if we need to interact with the [currentUser] before logging in.
Stream<BaseAuthUser> prototypeAppSupabaseUserStream() {
  final authStream = AuthRepository.instance.sessionStream.debounce(
    (session) => TimerStream(session, Duration(milliseconds: 300)),
  );
  return (!loggedIn
          ? Stream<AuthSession?>.value(null).concatWith([authStream])
          : authStream)
      .map<BaseAuthUser>((session) {
    currentUser = PrototypeAppSupabaseUser(session);
    return currentUser!;
  });
}
