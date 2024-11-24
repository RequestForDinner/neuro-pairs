import 'package:neuro_pairs/data/data_sources/interfaces/i_preferences_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class PreferencesDataSource implements IPreferencesDataSource {
  final SharedPreferences _preferencesInstance;

  PreferencesDataSource(this._preferencesInstance);

  @override
  Future<bool> savePreference({
    required String key,
    required Object preference,
  }) async {
    if (preference is List<String>) {
      return _preferencesInstance.setStringList(key, preference);
    }

    return switch (preference.runtimeType) {
      const (bool) => _preferencesInstance.setBool(key, preference as bool),
      const (String) =>
        _preferencesInstance.setString(key, preference as String),
      const (int) => _preferencesInstance.setInt(key, preference as int),
      const (double) =>
        _preferencesInstance.setDouble(key, preference as double),
      _ => throw UnimplementedError(),
    };
  }

  @override
  Object? fetchPreference({required String key}) {
    return _preferencesInstance.get(key);
  }

  @override
  Future<bool> removePreference({required String key}) {
    return _preferencesInstance.remove(key);
  }
}
