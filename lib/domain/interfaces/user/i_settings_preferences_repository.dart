abstract interface class ISettingsPreferencesRepository {
  String fetchLocale();

  Future<bool> saveLocale({required String locale});

  bool fetchVibrationInApp();

  Future<bool> saveVibrationInApp({required bool needVibrationInGame});

  bool fetchSoundInApp();

  Future<bool> saveSoundInApp({required bool needSoundInGame});
}
