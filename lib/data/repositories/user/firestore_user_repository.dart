import 'dart:typed_data';

import 'package:neuro_pairs/data/data_sources/interfaces/i_user_data_source.dart';
import 'package:neuro_pairs/domain/entities/user/user.dart';
import 'package:neuro_pairs/domain/interfaces/user/i_user_repository.dart';
import 'package:rxdart/rxdart.dart';

final class FireStoreUserRepository implements IUserRepository {
  final IUserDataSource _userDataSource;

  FireStoreUserRepository(this._userDataSource);

  final _userSubject = BehaviorSubject<User?>();

  @override
  User? get user => _userSubject.hasValue ? _userSubject.value : null;

  @override
  Stream<User?> get userStream => _userSubject;

  @override
  Future<User> createUser({required User user}) async {
    await _userDataSource.createUser(user: user);

    _userSubject.add(user);

    return user;
  }

  @override
  Future<void> deleteUser({required String uid}) async {
    await _userDataSource.deleteUser(uid: uid);

    _userSubject.add(null);
  }

  @override
  Future<User> fetchUser({required String uid}) async {
    final user = await _userDataSource.fetchUser(uid: uid);

    _userSubject.add(user);

    return user;
  }

  @override
  Future<User> updateUser({required User user}) async {
    await _userDataSource.updateUser(user: user);

    _userSubject.add(user);

    return user;
  }

  @override
  Future<String> uploadNewUserImage({
    required Uint8List imageBytes,
  }) async {
    if (user == null) throw ArgumentError();

    return _userDataSource.uploadNewUserImage(
      uid: user!.uid,
      imageBytes: imageBytes,
    );
  }

  @override
  Future<void> deleteUserImage() async {
    if (user == null) return;

    await _userDataSource.deleteUserImage(uid: user!.uid);
  }

  @override
  Future<bool> nameAlreadyExist({required String name}) {
    return _userDataSource.nameAlreadyExist(name: name);
  }
}
