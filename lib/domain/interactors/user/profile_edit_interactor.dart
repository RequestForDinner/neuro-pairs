import 'dart:typed_data';

import 'package:neuro_pairs/domain/entities/user/user.dart';
import 'package:neuro_pairs/domain/interfaces/auth/i_auth_preferences_repository.dart';
import 'package:neuro_pairs/domain/interfaces/user/i_user_repository.dart';

final class ProfileEditInteractor {
  final IAuthPreferencesRepository _authPreferencesRepository;
  final IUserRepository _userRepository;

  ProfileEditInteractor(this._authPreferencesRepository, this._userRepository);

  Stream<User?> get userStream => _userRepository.userStream;

  User? get user => _userRepository.user;

  Future<User?> updateUser({
    required User updatedUser,
    Uint8List? imageBytes,
  }) async {
    if (user == null) return null;

    var userForChanging = updatedUser;

    final updatedAvatarUrlNotNull = userForChanging.avatarUrl != null;
    if ((updatedAvatarUrlNotNull) && user!.avatarUrl != updatedUser.avatarUrl) {
      if (imageBytes == null) throw ArgumentError();
      final avatarUrl = await _userRepository.uploadNewUserImage(
        imageBytes: imageBytes,
      );

      userForChanging = userForChanging.copyWith(avatarUrl: avatarUrl);
    }

    if (!updatedAvatarUrlNotNull) {
      _userRepository.deleteUserImage();
    }

    return _userRepository.updateUser(user: userForChanging);
  }

  Future<bool> nameAlreadyExists({required String lowerCaseName}) async {
    if (lowerCaseName == user?.lowerCaseName) return false;

    return _userRepository.nameAlreadyExist(name: lowerCaseName);
  }
}
