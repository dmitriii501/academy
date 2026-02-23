import 'dart:async';

import 'package:flutter/material.dart';
import '/auth/auth_manager.dart';
import '/backend/api_client/auth_repository.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'email_auth.dart';

import 'supabase_user_provider.dart';

export '/auth/base_auth_user_provider.dart';

class SupabaseAuthManager extends AuthManager with EmailSignInManager {
  @override
  Future signOut() {
    return AuthRepository.instance.logout();
  }

  @override
  Future deleteUser(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Удаление пользователя не реализовано')),
    );
  }

  @override
  Future updateEmail({
    required String email,
    required BuildContext context,
  }) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Смена email не реализована')),
    );
  }

  Future updatePassword({
    required String newPassword,
    required BuildContext context,
  }) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Смена пароля не реализована')),
    );
  }

  @override
  Future resetPassword({
    required String email,
    required BuildContext context,
    String? redirectTo,
  }) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Сброс пароля не реализован')),
    );
  }

  @override
  Future<BaseAuthUser?> signInWithEmail(
    BuildContext context,
    String email,
    String password,
  ) =>
      _signInOrCreateAccount(
        context,
        () => emailSignInFunc(email, password),
      );

  @override
  Future<BaseAuthUser?> createAccountWithEmail(
    BuildContext context,
    String email,
    String password,
  ) =>
      _signInOrCreateAccount(
        context,
        () => emailCreateAccountFunc(email, password),
      );

  /// Tries to sign in or create an account using Supabase Auth.
  /// Returns the User object if sign in was successful.
  Future<BaseAuthUser?> _signInOrCreateAccount(
    BuildContext context,
    Future<AuthSession?> Function() signInFunc,
  ) async {
    try {
      final session = await signInFunc();
      final authUser =
          session == null ? null : PrototypeAppSupabaseUser(session);

      // Update currentUser here in case user info needs to be used immediately
      // after a user is signed in. This should be handled by the user stream,
      // but adding here too in case of a race condition where the user stream
      // doesn't assign the currentUser in time.
      if (authUser != null) {
        currentUser = authUser;
        AppStateNotifier.instance.update(authUser);
      }
      return authUser;
    } catch (e) {
      final errorMsg = 'Ошибка авторизации: $e';
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg)),
      );
      return null;
    }
  }
}
