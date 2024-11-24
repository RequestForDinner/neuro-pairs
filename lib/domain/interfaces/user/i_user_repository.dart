import 'dart:typed_data';

import 'package:neuro_pairs/domain/entities/user/user.dart';

abstract interface class IUserRepository {
  Stream<User?> get userStream;

  User? get user;

  Future<User> createUser({required User user});

  Future<User> fetchUser({required String uid});

  Future<User> updateUser({required User user});

  Future<void> deleteUser({required String uid});

  Future<String> uploadNewUserImage({
    required Uint8List imageBytes,
  });

  Future<void> deleteUserImage();

  Future<bool> nameAlreadyExist({required String name});
}
