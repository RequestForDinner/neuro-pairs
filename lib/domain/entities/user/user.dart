import 'dart:math';

final class User {
  final String uid;
  final String? email;
  final String username;
  final String lowerCaseName;
  final String? avatarUrl;

  const User({
    required this.uid,
    required this.username,
    required this.lowerCaseName,
    this.email,
    this.avatarUrl,
  });

  factory User.unfounded() {
    final randomUserName = 'user${Random().nextInt(2000000000)}';

    return User(
      uid: UserStatus.unfounded,
      lowerCaseName: randomUserName,
      username: randomUserName,
    );
  }

  User copyWith({
    String? uid,
    String? email,
    String? username,
    String? avatarUrl,
    bool needClearAvatarUrl = false,
  }) {
    return User(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      lowerCaseName: username?.toLowerCase() ?? this.username.toLowerCase(),
      username: username ?? this.username,
      avatarUrl: needClearAvatarUrl ? avatarUrl : avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is User &&
      uid == other.uid &&
      email == other.email &&
      username == other.username &&
      avatarUrl == other.avatarUrl;

  @override
  int get hashCode =>
      uid.hashCode ^ email.hashCode ^ username.hashCode ^ avatarUrl.hashCode;
}

abstract final class UserStatus {
  static const unfounded = '-1';
}
