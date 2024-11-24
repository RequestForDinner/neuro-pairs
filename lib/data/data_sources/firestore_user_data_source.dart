import 'dart:typed_data';

import 'package:neuro_pairs/data/data_sources/interfaces/i_user_data_source.dart';
import 'package:neuro_pairs/data/mappers/user/user_mapper.dart';
import 'package:neuro_pairs/data/services/firestore_service.dart';
import 'package:neuro_pairs/data/services/storage_service.dart';
import 'package:neuro_pairs/domain/entities/user/user.dart';

final class FireStoreUserDataSource implements IUserDataSource {
  static const _usersCollection = 'users';
  static const _usersStorageRef = 'usersAvatars';

  final _fireStoreInstance = FireStoreService(_usersCollection);
  final _storageService = StorageService();
  final _userMapper = UserMapper();

  @override
  Future<User> createUser({required User user}) async {
    try {
      final userMap = _userMapper.toMap(user);

      await _fireStoreInstance.createDoc(docId: user.uid, data: userMap);

      return user;
    } on Object catch (e, stackTrace) {
      rethrow;
    }
  }

  @override
  Future<void> deleteUser({required String uid}) async {
    try {
      await _fireStoreInstance.deleteDoc(docId: uid);
    } on Object catch (e, stackTrace) {
      rethrow;
    }
  }

  @override
  Future<User> fetchUser({required String uid}) async {
    try {
      print(uid);
      final userMap = await _fireStoreInstance.fetchDoc(docId: uid);
      if (userMap == null) return User.unfounded();

      final user = _userMapper.fromMap(userMap);

      return user;
    } on Object catch (e, stackTrace) {
      rethrow;
    }
  }

  @override
  Future<User> updateUser({required User user}) async {
    try {
      final userMap = _userMapper.toMap(user);

      await _fireStoreInstance.updateDoc(docId: user.uid, data: userMap);

      return user;
    } on Object catch (e, stackTrace) {
      rethrow;
    }
  }

  Future<bool> userAlreadyExists({required String uid}) async {
    final userAlreadyExists = await _fireStoreInstance.containsDoc(docId: uid);

    return userAlreadyExists;
  }

  @override
  Future<String> uploadNewUserImage({
    required String uid,
    required Uint8List imageBytes,
  }) async {
    return _storageService.uploadImageBytes(
      directory: '$_usersStorageRef/$uid',
      imageBytes: imageBytes,
    );
  }

  @override
  Future<void> deleteUserImage({required String uid}) {
    return _storageService.deleteFile(
      directory: '$_usersStorageRef/$uid',
    );
  }

  @override
  Future<bool> nameAlreadyExist({required String name}) async {
    try {
      final alreadyExists = await _fireStoreInstance.containsDocByValue(
        field: 'lowerCaseName',
        value: name,
      );

      return alreadyExists;
    } on Object catch (_) {
      rethrow;
    }
  }
}
