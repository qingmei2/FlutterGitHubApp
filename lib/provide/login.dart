import 'package:flutter/material.dart';

class LoginProvide with ChangeNotifier {
  String username;
  String password;

  Future<Null> login() async {

  }
}

enum LoginPageEvent {

  /// 用户名为空
  emptyUsernameInput,
  /// 密码为空
  emptyPasswordInput,
  /// 账号密码错误
  loginFailedWithAuthError
}
