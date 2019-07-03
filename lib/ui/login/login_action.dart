import 'package:flutter_rhine/common/common.dart';

abstract class LoginAction {}

/// 初始化事件
class InitialAction extends LoginAction {
  final bool shouldAutoLogin;

  InitialAction({this.shouldAutoLogin}) : assert(shouldAutoLogin != null);
}

/// 用户点击登录事件
class LoginClickedAction extends LoginAction {
  final String username;
  final String password;

  LoginClickedAction({this.username, this.password});
}

class LoginLoadingAction extends LoginAction {}

class LoginSuccessAction extends LoginAction {
  final User user;
  final String token;

  LoginSuccessAction(this.user, this.token);
}

class LoginFailureAction extends LoginAction {
  final String errorMessage;

  LoginFailureAction(this.errorMessage);
}
