import 'package:flutter_rhine/common/common.dart';

@immutable
class LoginState {
  final String username;
  final String password;
  final bool isLoading;

  /// 用户信息，当用户信息不为空时，视为登录成功，跳转login页面
  final User user;
  final bool isLoginCancel;

  final Exception error;

  LoginState(
      {this.username,
      this.password,
      this.isLoading = false,
      this.isLoginCancel = false,
      this.user,
      this.error});

  LoginState copyWith({
    String username,
    String password,
    bool isLoading,
    User user,
    bool isLoginCancel,
    Exception error,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      isLoginCancel: isLoginCancel ?? this.isLoginCancel,
      user: user ?? this.user,
      error: error,
    );
  }

  factory LoginState.initial() =>
      LoginState(username: '', password: '', isLoading: false);

  @override
  String toString() {
    return 'LoginState{username: $username, password: $password, isLoading: $isLoading, user: $user, isLoginCancel: $isLoginCancel, error: $error}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginState &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          password == other.password &&
          isLoading == other.isLoading &&
          user == other.user &&
          isLoginCancel == other.isLoginCancel &&
          error == other.error;

  @override
  int get hashCode =>
      username.hashCode ^
      password.hashCode ^
      isLoading.hashCode ^
      user.hashCode ^
      isLoginCancel.hashCode ^
      error.hashCode;
}
