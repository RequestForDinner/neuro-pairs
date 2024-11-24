import 'package:neuro_pairs/domain/entities/statistic/statistic.dart';
import 'package:neuro_pairs/domain/entities/user/user.dart';
import 'package:neuro_pairs/domain/interfaces/auth/i_auth_preferences_repository.dart';
import 'package:neuro_pairs/domain/interfaces/auth/i_remote_auth_repository.dart';
import 'package:neuro_pairs/domain/interfaces/statistic/i_statistic_repository.dart';
import 'package:neuro_pairs/domain/interfaces/user/i_user_repository.dart';

final class ProfileInteractor {
  final IUserRepository _userRepository;
  final IAuthPreferencesRepository _authPreferencesRepository;
  final IRemoteAuthRepository _authRepository;
  final IStatisticRepository _statisticRepository;

  const ProfileInteractor(
    this._userRepository,
    this._authPreferencesRepository,
    this._authRepository,
    this._statisticRepository,
  );

  Stream<User?> get userStream => _userRepository.userStream;

  Stream<Statistic> get statisticStream => _statisticRepository.statisticStream;

  Future<void> updateUser({required User user}) {
    return _userRepository.updateUser(user: user);
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }
}
