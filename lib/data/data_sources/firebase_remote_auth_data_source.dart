import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:neuro_pairs/data/data_sources/interfaces/i_remote_auth_data_source.dart';
import 'package:neuro_pairs/domain/utils/app_logger.dart';
import 'package:neuro_pairs/domain/utils/typedefs.dart';

final class FirebaseRemoteAuthDataSource implements IRemoteAuthDataSource {
  FirebaseRemoteAuthDataSource();

  late final _firebaseAuth = FirebaseAuth.instance;
  late final _googleSignInService = GoogleSignIn();

  @override
  Stream<bool> get authStateStream => _AuthStatusTransformer().bind(
        _firebaseAuth.authStateChanges(),
      );

  @override
  String? get userCredentialUid => _firebaseAuth.currentUser?.uid;

  @override
  UserDisplayCredential signInWithGoogle() async {
    try {
      final signInAccount = await _googleSignInService.signIn();
      if (signInAccount == null) {
        throw Exception("Sign in account wasn't found");
      }

      final googleAuth = await signInAccount.authentication;
      final oAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        oAuthCredential,
      );
      if (userCredential.user == null) {
        throw Exception("User Credential wasn't found");
      }

      AppLogger.logInfo('Successful fetching google user credential');

      final user = userCredential.user!;

      return (
        uid: user.uid,
        photoUrl: user.photoURL,
        email: user.email,
        displayName: user.displayName,
      );
    } catch (e, stackTrace) {
      AppLogger.logError(
        'Something went wrong',
        error: e,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignInService.signOut();

      AppLogger.logInfo('Sign out process passed');
    } catch (e, stackTrace) {
      AppLogger.logError(
        'Something went wrong',
        error: e,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }
}

class _AuthStatusTransformer implements StreamTransformer<User?, bool> {
  @override
  Stream<bool> bind(Stream<User?> stream) {
    return stream.map((user) => user != null);
  }

  @override
  StreamTransformer<RS, RT> cast<RS, RT>() => StreamTransformer.castFrom(this);
}
