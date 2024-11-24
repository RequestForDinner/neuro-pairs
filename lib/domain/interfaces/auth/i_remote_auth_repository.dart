import 'package:neuro_pairs/domain/utils/typedefs.dart';

abstract interface class IRemoteAuthRepository {
  Stream<bool> get authStateStream;

  String? get userCredentialUid;

  UserDisplayCredential signInWithGoogle();

  Future<void> signOut();
}
