import 'package:neuro_pairs/domain/entities/user/user.dart';

final class UserMapper {
  User fromMap(Map<String, dynamic> map) {
    return User(
      uid: map[_Fields.uid],
      username: map[_Fields.username],
      lowerCaseName: map[_Fields.lowerCaseName],
      email: map[_Fields.email],
      avatarUrl: map[_Fields.avatarUrl],
    );
  }

  Map<String, dynamic> toMap(User user) {
    return {
      _Fields.uid: user.uid,
      _Fields.username: user.username,
      _Fields.lowerCaseName: user.username.toLowerCase(),
      if (user.email != null) _Fields.email: user.email,
      if (user.avatarUrl != null) _Fields.avatarUrl: user.avatarUrl,
    };
  }
}

abstract final class _Fields {
  static const uid = 'uid';
  static const username = 'username';
  static const lowerCaseName = 'lowerCaseName';
  static const email = 'email';
  static const avatarUrl = 'avatarUrl';
}
