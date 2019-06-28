abstract class LoginEvent {}

/// 初始化事件
class InitialEvent extends LoginEvent {
  /// 默认是否自动登录
  final bool shouldAutoLogin;

  InitialEvent({this.shouldAutoLogin}) : assert(shouldAutoLogin != null);
}

/// 用户点击登录事件
class LoginClickedEvent extends LoginEvent {
  final String username;
  final String password;

  LoginClickedEvent({this.username, this.password});
}
