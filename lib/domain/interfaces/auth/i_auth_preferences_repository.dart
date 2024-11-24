abstract interface class IAuthPreferencesRepository {
  Future<bool> saveUserUid({required String userUid});

  String? fetchUserUid();

  Future<bool> clearSavedUserUid();
}
