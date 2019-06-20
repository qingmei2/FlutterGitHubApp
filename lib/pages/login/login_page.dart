import 'package:flutter/material.dart';
import 'package:flutter_rhine/constants/assets.dart';
import 'package:flutter_rhine/constants/colors.dart';
import 'package:flutter_rhine/dao/dao_result.dart';
import 'package:flutter_rhine/pages/main/main_page.dart';
import 'package:flutter_rhine/provide/login/login_provide.dart';
import 'package:flutter_rhine/routers/application.dart';
import 'package:flutter_rhine/widget/global_progress_bar.dart';
import 'package:provide/provide.dart';

class LoginPage extends StatelessWidget {
  static final String path = 'login_page';

  @override
  Widget build(BuildContext context) {
    // 先尝试自动登录
    _tryAutoLogin(context);
    return Provide<LoginProvide>(builder: (context, child, val) {
      final LoginProvide provide = Provide.value<LoginProvide>(context);
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
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.loose,
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      _loginTitle(),
                      _usernameInput(context),
                      _passwordInput(context),
                      _signInButton(context)
                    ],
                  ),
                ),
                ProgressBar(
                  visibility: provide.progressVisible ?? false,
                ),
              ],
            ),
          ),
        ),
      );
    });
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
          controller: TextEditingController(
              text: Provide.value<LoginProvide>(context).username),
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
          controller: TextEditingController(
              text: Provide.value<LoginProvide>(context).password),
          keyboardType: TextInputType.text,
          obscureText: true,
          // 输入密码模式
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

  /// 尝试自动登录
  void _tryAutoLogin(BuildContext context) {
    final LoginProvide provide = Provide.value<LoginProvide>(context);
    provide.autoLogin().then((res) => _onLoginSuccess(context, res));
  }

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
    result.then((res) => _onLoginSuccess(context, res));
  }

  /// 登录结果处理
  void _onLoginSuccess(BuildContext context, DataResult res) {
    if (res != null && res.result) {
      // 登录成功，跳转主页面
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context);
        Application.router.navigateTo(context, MainPage.path);
        return true;
      });
    }
    // 登录失败
  }
}
