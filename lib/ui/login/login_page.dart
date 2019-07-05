import 'package:flutter/material.dart';
import 'package:flutter_rhine/common/common.dart';
import 'package:flutter_rhine/repository/repository.dart';

import 'login.dart';

/// 登录成功的回调函数
/// [context] 上下文对象
/// [user] 用户信息
/// [token] 用户token
typedef void LoginSuccessCallback(
  final BuildContext context,
  final User user,
  final String token,
);

/// 取消登录的回调函数
/// [context] 上下文对象
typedef void LoginCancelCallback(
  final BuildContext context,
);

@immutable
class LoginPage extends StatelessWidget {
  final UserRepository userRepository;
  final LoginSuccessCallback loginSuccessCallback;
  final LoginCancelCallback loginCancelCallback;

  LoginPage({
    Key key,
    @required this.userRepository,
    this.loginSuccessCallback,
    this.loginCancelCallback,
  })  : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginState>(
      converter: (store) => store.state.loginState,
      builder: (BuildContext context, LoginState loginState) => Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  'Sign in',
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            body: LoginForm(loginSuccessCallback, loginCancelCallback),
          ),
    );
  }
}
