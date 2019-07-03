import 'package:meta/meta.dart';

/// 用户鉴权事件
abstract class AuthenticationEvent {}

/// APP启动
class AppStart extends AuthenticationEvent {
  @override
  String toString() => 'AppStart';
}

/// 登录
class LoggedIn extends AuthenticationEvent {
  final String token;

  LoggedIn({@required this.token});

  @override
  String toString() => 'LoggedIn';
}

/// 登出
class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}
