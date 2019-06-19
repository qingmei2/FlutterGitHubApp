import 'package:flutter/material.dart';
import 'package:flutter_rhine/constants/assets.dart';
import 'package:flutter_rhine/constants/colors.dart';
import 'package:flutter_rhine/pages/home/main_page.dart';
import 'package:flutter_rhine/provide/login.dart';
import 'package:flutter_rhine/routers/application.dart';
import 'package:provide/provide.dart';

class LoginPage extends StatelessWidget {
  static final String path = 'login_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            'Sign in',
            textAlign: TextAlign.start,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 38.0, 16.0, 8.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _loginTitle(),
                _usernameInput(context),
                _passwordInput(context),
                _signInButton(context)
              ],
            ),
          ),
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
  Widget _usernameInput(BuildContext context) => Container(
        margin: EdgeInsets.only(top: 24.0),
        child: TextField(
          keyboardType: TextInputType.text,
          onChanged: (String newValue) =>
              Provide.value<LoginProvide>(context).onUserNameChanged(newValue),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            labelText: 'Username or email address',
          ),
        ),
      );

  /// 密码输入框
  Widget _passwordInput(BuildContext context) => Container(
        margin: EdgeInsets.only(top: 8.0),
        child: TextField(
          keyboardType: TextInputType.text,
          onChanged: (String newValue) =>
              Provide.value<LoginProvide>(context).onPasswordChanged(newValue),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            labelText: 'Password',
          ),
        ),
      );

  /// 登录按钮
  Widget _signInButton(BuildContext context) => Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 32.0),
        width: double.infinity,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: double.infinity,
            minHeight: 50.0,
          ),
          child: FlatButton(
            onPressed: () => _onLoginButtonClicked(context),
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

  /// 登录按钮点击事件
  void _onLoginButtonClicked(BuildContext context) {
    final LoginProvide provide = Provide.value<LoginProvide>(context);
    final String username = provide.username;
    final String password = provide.password;

    if (username == null || username.length == 0) {
      return;
    }
    if (password == null || password.length == 0) {
      return;
    }

    final Future result = provide.login();
    result.then((res) {
      Navigator.pop(context);
      if (res != null && res.result) {
        Future.delayed(const Duration(seconds: 1), () {
          Application.router.navigateTo(context, MainPage.path);
        });
      }
    });
  }
}
