import 'package:flutter_rhine/common/common.dart';

@immutable
class AppUser {
  final User user;
  final String token;

  AppUser({
    this.user,
    this.token,
  });

  AppUser copyWith({
    User user,
    String token,
  }) {
    return AppUser(
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppUser &&
          runtimeType == other.runtimeType &&
          user == other.user &&
          token == other.token;

  @override
  int get hashCode => user.hashCode ^ token.hashCode;

  @override
  String toString() {
    return 'AppUser{user: $user, token: $token}';
  }
}
