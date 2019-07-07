import 'package:flutter_rhine/common/common.dart';

abstract class LoginAction {}

/// 初始化事件
class InitialAction extends LoginAction {
  final bool shouldAutoLogin;

  InitialAction({this.shouldAutoLogin}) : assert(shouldAutoLogin != null);
}

/// 释放事件
class LoginDisposeAction extends LoginAction {}

/// 用户点击登录事件
class LoginClickedAction extends LoginAction {
  final String username;
  final String password;

  LoginClickedAction({this.username, this.password});
}

/// 用户自动登录事件
class AutoLoginAction extends LoginAction {
  final String username;
  final String password;

  AutoLoginAction({this.username, this.password});
}

/// 登录中
class LoginLoadingAction extends LoginAction {}

/// 登录成功
class LoginSuccessAction extends LoginAction {
  final User user;
  final String token;

  LoginSuccessAction(this.user, this.token);
}

/// 登录失败
class LoginFailureAction extends LoginAction {
  final Exception exception;

  LoginFailureAction(this.exception);
}
