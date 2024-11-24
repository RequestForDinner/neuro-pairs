import 'package:neuro_pairs/data/data_sources/interfaces/i_preferences_data_source.dart';
import 'package:neuro_pairs/domain/interfaces/auth/i_auth_preferences_repository.dart';

final class AuthPreferencesRepository implements IAuthPreferencesRepository {
  final IPreferencesDataSource _preferencesDataSource;

  AuthPreferencesRepository(this._preferencesDataSource);

  @override
  Future<bool> saveUserUid({required String userUid}) {
    return _preferencesDataSource.savePreference(
      key: _PreferencesKeys.userUidKey,
      preference: userUid,
    );
  }

  @override
  String? fetchUserUid() {
    return _preferencesDataSource.fetchPreference(
      key: _PreferencesKeys.userUidKey,
    ) as String?;
  }

  @override
  Future<bool> clearSavedUserUid() {
    return _preferencesDataSource.removePreference(
      key: _PreferencesKeys.userUidKey,
    );
  }
}

abstract final class _PreferencesKeys {
  static const String userUidKey = 'userUid';
}
