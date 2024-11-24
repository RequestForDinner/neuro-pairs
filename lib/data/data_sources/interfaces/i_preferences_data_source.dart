abstract interface class IPreferencesDataSource {
  Future<bool> savePreference({
    required String key,
    required Object preference,
  });

  Object? fetchPreference({required String key});

  Future<bool> removePreference({required String key});
}
