import 'package:flutter_rhine/common/common.dart';

@immutable
class LoginState {
  final String username;
  final String password;
  final bool isLoading;

  final bool isLoginSuccess;
  final bool isLoginCancel;

  LoginState({
    this.username,
    this.password,
    this.isLoading,
    this.isLoginCancel,
    this.isLoginSuccess,
  });

  LoginState copyWith({
    String username,
    String password,
    bool isLoading,
    bool isLoginSuccess,
    bool isLoginCancel,
  }) {
    return LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
        isLoading: isLoading ?? this.isLoading,
        isLoginCancel: isLoginCancel ?? this.isLoginCancel,
        isLoginSuccess: isLoginSuccess ?? this.isLoginSuccess);
  }

  factory LoginState.initial() =>
      LoginState(username: '', password: '', isLoading: false);

  @override
  String toString() {
    return 'LoginState{username: $username, password: $password, isLoading: $isLoading, isLoginSuccess: $isLoginSuccess, isLoginCancel: $isLoginCancel}';
  }
}
