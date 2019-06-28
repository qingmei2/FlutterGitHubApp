/// 用户信息状态
abstract class AuthenticationState {}

/// 未检查用户信息
class AuthenticationUninitialized extends AuthenticationState {
  @override
  String toString() => 'AuthUninitialized';
}

/// 用户已登录
class AuthenticationAuthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthAuthenticated';
}

/// 用户身份鉴权失败
class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthUnauthenticated';
}

/// 用户登录中
class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() => 'AuthLoading';
}
