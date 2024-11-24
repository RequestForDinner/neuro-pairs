import 'package:neuro_pairs/data/data_sources/interfaces/i_preferences_data_source.dart';
import 'package:neuro_pairs/domain/interfaces/user/i_settings_preferences_repository.dart';

final class SettingsPreferencesRepository
    implements ISettingsPreferencesRepository {
  final IPreferencesDataSource _preferencesDataSource;

  const SettingsPreferencesRepository(this._preferencesDataSource);

  @override
  String fetchLocale() {
    final locale = _preferencesDataSource.fetchPreference(
      key: _Fields.locale,
    ) as String?;

    return locale ?? 'en';
  }

  @override
  bool fetchSoundInApp() {
    final needSoundInApp = _preferencesDataSource.fetchPreference(
      key: _Fields.sound,
    ) as bool?;

    return needSoundInApp ?? true;
  }

  @override
  bool fetchVibrationInApp() {
    final needVibrationInApp = _preferencesDataSource.fetchPreference(
      key: _Fields.vibration,
    ) as bool?;

    return needVibrationInApp ?? true;
  }

  @override
  Future<bool> saveLocale({required String locale}) {
    return _preferencesDataSource.savePreference(
      key: _Fields.locale,
      preference: locale,
    );
  }

  @override
  Future<bool> saveSoundInApp({required bool needSoundInGame}) {
    return _preferencesDataSource.savePreference(
      key: _Fields.sound,
      preference: needSoundInGame,
    );
  }

  @override
  Future<bool> saveVibrationInApp({required bool needVibrationInGame}) {
    return _preferencesDataSource.savePreference(
      key: _Fields.vibration,
      preference: needVibrationInGame,
    );
  }
}

abstract final class _Fields {
  static const locale = 'locale';
  static const vibration = 'vibration';
  static const sound = 'sounds';
}
