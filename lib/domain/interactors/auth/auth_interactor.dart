import 'dart:math';

import 'package:neuro_pairs/domain/entities/statistic/statistic.dart';
import 'package:neuro_pairs/domain/entities/user/user.dart';
import 'package:neuro_pairs/domain/interfaces/auth/i_auth_preferences_repository.dart';
import 'package:neuro_pairs/domain/interfaces/auth/i_remote_auth_repository.dart';
import 'package:neuro_pairs/domain/interfaces/statistic/i_statistic_repository.dart';
import 'package:neuro_pairs/domain/interfaces/user/i_user_repository.dart';

final class AuthInteractor {
  final IRemoteAuthRepository _remoteAuthRepository;
  final IAuthPreferencesRepository _authPreferencesRepository;
  final IUserRepository _userRepository;
  final IStatisticRepository _statisticRepository;

  const AuthInteractor(
    this._remoteAuthRepository,
    this._authPreferencesRepository,
    this._userRepository,
    this._statisticRepository,
  );

  Future<void> signInWithGoogle() async {
    final userDisplayCredential =
        await _remoteAuthRepository.signInWithGoogle();

    await _saveUserUidLocally(userDisplayCredential.uid);

    final user = await _userRepository.fetchUser(
      uid: userDisplayCredential.uid,
    );

    final randomUsername = 'user${Random().nextInt(2000000000)}';
    if (user.uid == UserStatus.unfounded) {
      final newUser = User(
        uid: userDisplayCredential.uid,
        username: userDisplayCredential.displayName ?? randomUsername,
        lowerCaseName:
            userDisplayCredential.displayName?.toLowerCase() ?? randomUsername,
        email: userDisplayCredential.email,
        avatarUrl: userDisplayCredential.photoUrl,
      );

      await _userRepository.createUser(user: newUser);
      await _statisticRepository.createNewStatistic(
        userUid: userDisplayCredential.uid,
        statistic: Statistic.empty(),
      );
    }
  }

  Future<bool> _saveUserUidLocally(String userUid) {
    return _authPreferencesRepository.saveUserUid(userUid: userUid);
  }
}
