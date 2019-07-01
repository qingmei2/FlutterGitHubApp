import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rhine/common/constants/constants.dart';
import 'package:flutter_rhine/common/widget/global_progress_bar.dart';

import 'login.dart';
import 'login_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context)
      ..dispatch(InitialEvent(shouldAutoLogin: true));

    return Container(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 38.0, 16.0, 8.0),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.loose,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _loginTitle(),
                  _usernameInput(),
                  _passwordInput(),
                  _signInButton()
                ],
              ),
            ),
            BlocBuilder<LoginEvent, LoginState>(
              bloc: loginBloc,
              builder: (context, state) {
                return ProgressBar(
                  visibility: state.isLoading,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 顶部图标和标题
  Widget _loginTitle() => Row(
        children: <Widget>[
          Image(
            image: AssetImage(imageGithubCat),
            width: 65.0,
            height: 65.0,
            fit: BoxFit.fitWidth,
          ),
          Container(
            margin: EdgeInsets.only(left: 32.0),
            child: Text(
              'Sign into GitHub',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.normal,
                color: colorPrimaryText,
              ),
              maxLines: 1,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      );

  /// 用户名输入框
  Widget _usernameInput() {
    final bloc = BlocProvider.of<LoginBloc>(context);
    final state = bloc.currentState;
    userNameController.text = state.username;

    return BlocBuilder<LoginEvent, LoginState>(
      bloc: bloc,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(top: 24.0),
          child: TextField(
            controller: userNameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              labelText: 'Username or email address',
            ),
          ),
        );
      },
    );
  }

  /// 密码输入框
  Widget _passwordInput() {
    final bloc = BlocProvider.of<LoginBloc>(context);
    passwordController.text = bloc.currentState.password;
    return BlocBuilder<LoginEvent, LoginState>(
      bloc: bloc,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(top: 8.0),
          child: TextField(
            controller: passwordController,
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              labelText: 'Password',
            ),
          ),
        );
      },
    );
  }

  /// 登录按钮
  Widget _signInButton() {
    final bloc = BlocProvider.of<LoginBloc>(context);

    /// 登录按钮点击事件
    void _onLoginButtonClicked(LoginBloc bloc) {
      final String username = userNameController.text;
      final String password = passwordController.text;

      if (username == null || username.length == 0) {
        return;
      }
      if (password == null || password.length == 0) {
        return;
      }

      bloc.dispatch(LoginClickedEvent(username: username, password: password));
    }

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 32.0),
      width: double.infinity,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: double.infinity,
          minHeight: 50.0,
        ),
        child: FlatButton(
          onPressed: () => _onLoginButtonClicked(bloc),
          color: colorSecondaryDark,
          highlightColor: colorPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(7.0)),
          ),
          child: Text(
            'Sign in',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
