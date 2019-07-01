import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rhine/repository/repository.dart';
import 'package:flutter_rhine/routers/application.dart';
import 'package:flutter_rhine/ui/main/main_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  static final String path = 'login_page';

  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginBloc bloc = LoginBloc(userRepository);
    return BlocProvider(
      builder: (context) => bloc,
      child: Scaffold(
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
        body: BlocListener<LoginEvent, LoginState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is LoginFailure) {
              Fluttertoast.showToast(msg: state.errorMessage);
            }
            if (state is LoginSuccess) {
              _onLoginSuccess(context);
            }
          },
          child: LoginForm(),
        ),
      ),
    );
  }

  /// 登录结果处理
  void _onLoginSuccess(BuildContext context) {
    //登录成功，跳转主页面
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
      Application.router.navigateTo(context, MainPage.path);
      return true;
    });
  }
}
