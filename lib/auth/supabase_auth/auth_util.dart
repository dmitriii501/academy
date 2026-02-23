import '/backend/api_client/auth_repository.dart';
import 'supabase_auth_manager.dart';
import 'supabase_user_provider.dart';

export 'supabase_auth_manager.dart';

final _authManager = SupabaseAuthManager();
SupabaseAuthManager get authManager => _authManager;

String get currentUserEmail => currentUser?.email ?? '';

String get currentUserUid => currentUser?.uid ?? '';

String get currentUserDisplayName => currentUser?.displayName ?? '';

String get currentUserPhoto => currentUser?.photoUrl ?? '';

String get currentPhoneNumber => currentUser?.phoneNumber ?? '';

String get currentJwtToken => _currentJwtToken ?? '';

bool get currentUserEmailVerified => currentUser?.emailVerified ?? false;

/// Create a Stream that listens to the current user's JWT Token.
String? _currentJwtToken;
final jwtTokenStream = AuthRepository.instance.sessionStream.map((session) {
  _currentJwtToken = session.accessToken;
  return session.accessToken;
}).asBroadcastStream();
