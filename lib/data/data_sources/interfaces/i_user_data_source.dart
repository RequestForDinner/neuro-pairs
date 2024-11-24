import 'dart:typed_data';

import 'package:neuro_pairs/domain/entities/user/user.dart';

abstract interface class IUserDataSource {
  Future<User> createUser({required User user});

  Future<User> fetchUser({required String uid});

  Future<User> updateUser({required User user});

  Future<void> deleteUser({required String uid});

  Future<String> uploadNewUserImage({
    required String uid,
    required Uint8List imageBytes,
  });

  Future<void> deleteUserImage({required String uid});

  Future<bool> nameAlreadyExist({required String name});
}
