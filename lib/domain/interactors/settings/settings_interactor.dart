import 'package:neuro_pairs/domain/entities/user/user.dart';
import 'package:neuro_pairs/domain/interfaces/user/i_settings_preferences_repository.dart';
import 'package:neuro_pairs/domain/interfaces/user/i_user_repository.dart';

final class SettingsInteractor {
  final IUserRepository _userRepository;
  final ISettingsPreferencesRepository _settingsPreferencesRepository;

  const SettingsInteractor(
    this._userRepository,
    this._settingsPreferencesRepository,
  );

  Stream<User?> get userStream => _userRepository.userStream;

  bool get needVibrationInApp =>
      _settingsPreferencesRepository.fetchVibrationInApp();

  bool get needSoundInApp => _settingsPreferencesRepository.fetchSoundInApp();

  String get savedLocaleName => _settingsPreferencesRepository.fetchLocale();

  void saveLocale({required String localeName}) =>
      _settingsPreferencesRepository.saveLocale(locale: localeName);

  void saveSoundsInApp({required bool soundsInApp}) =>
      _settingsPreferencesRepository.saveSoundInApp(
        needSoundInGame: soundsInApp,
      );

  void saveVibrationInApp({required bool vibrationInApp}) =>
      _settingsPreferencesRepository.saveVibrationInApp(
        needVibrationInGame: vibrationInApp,
      );
}
