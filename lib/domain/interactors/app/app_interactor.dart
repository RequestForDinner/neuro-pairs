import 'package:neuro_pairs/domain/interfaces/auth/i_auth_preferences_repository.dart';
import 'package:neuro_pairs/domain/interfaces/auth/i_remote_auth_repository.dart';
import 'package:neuro_pairs/domain/interfaces/statistic/i_statistic_repository.dart';
import 'package:neuro_pairs/domain/interfaces/user/i_user_repository.dart';

final class AppInteractor {
  final IUserRepository _userRepository;
  final IStatisticRepository _statisticRepository;
  final IAuthPreferencesRepository _authPreferencesRepository;
  final IRemoteAuthRepository _remoteAuthRepository;

  const AppInteractor(
    this._userRepository,
    this._statisticRepository,
    this._authPreferencesRepository,
    this._remoteAuthRepository,
  );

  Stream<bool> get authStateStream => _remoteAuthRepository.authStateStream;

  Future<void> fetchUser() async {
    final savedUserUid = _authPreferencesRepository.fetchUserUid() ??
        _remoteAuthRepository.userCredentialUid;

    if (savedUserUid != null && savedUserUid.isNotEmpty) {
      await Future.wait([
        _userRepository.fetchUser(uid: savedUserUid),
        _statisticRepository.fetchStatistic(userUid: savedUserUid)
      ]);
    }
  }

  void clearSavedUserUid() {
    _authPreferencesRepository.clearSavedUserUid();
  }
}
