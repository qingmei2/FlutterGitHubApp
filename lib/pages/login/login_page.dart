import 'package:flutter/material.dart';
import 'package:flutter_rhine/constants/assets.dart';
import 'package:flutter_rhine/constants/colors.dart';
import 'package:flutter_rhine/dao/dao_result.dart';
import 'package:flutter_rhine/pages/main/main_page.dart';
import 'package:flutter_rhine/providers/global/global_user_model.dart';
import 'package:flutter_rhine/providers/login/login_model.dart';
import 'package:flutter_rhine/routers/application.dart';
import 'package:flutter_rhine/widget/global_progress_bar.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static final String path = 'login_page';

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  GlobalUserModel _globalUserModel;

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 初始化Provider
    _globalUserModel = Provider.of<GlobalUserModel>(context);

    // 尝试自动登录
    _tryAutoLogin(_globalUserModel);
  }

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
              Consumer<LoginPageModel>(
                builder: (context, LoginPageModel _loginModel, child) =>
                    ProgressBar(
                      visibility: _loginModel.progressVisible ?? false,
                    ),
              ),
            ],
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
  Widget _usernameInput(BuildContext context) {
    return Consumer<LoginPageModel>(
      builder: (context, LoginPageModel model, child) => Container(
            margin: EdgeInsets.only(top: 24.0),
            child: TextField(
              controller: userNameController,
              keyboardType: TextInputType.text,
              onChanged: (String newValue) => model.onUserNameChanged(newValue),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                labelText: 'Username or email address',
              ),
            ),
          ),
    );
  }

  /// 密码输入框
  Widget _passwordInput(BuildContext context) {
    return Consumer<LoginPageModel>(
        builder: (context, LoginPageModel model, child) {
      return Container(
        margin: EdgeInsets.only(top: 8.0),
        child: TextField(
          controller: passwordController,
          keyboardType: TextInputType.text,
          obscureText: true,
          // 输入密码模式
          onChanged: (String newValue) => model.onPasswordChanged(newValue),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            labelText: 'Password',
          ),
        ),
      );
    });
  }

  /// 登录按钮
  Widget _signInButton(BuildContext context) {
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
          onPressed: () => _onLoginButtonClicked(),
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

  /// 尝试自动登录
  void _tryAutoLogin(GlobalUserModel globalUserModel) {
    Provider.of<LoginPageModel>(context)
        .tryAutoLogin(userNameController, passwordController, globalUserModel)
        .then((res) => _onLoginSuccess(res));
  }

  /// 登录按钮点击事件
  void _onLoginButtonClicked() {
    final LoginPageModel _loginModel = Provider.of<LoginPageModel>(context);

    final String username = _loginModel.username;
    final String password = _loginModel.password;

    if (username == null || username.length == 0) {
      return;
    }
    if (password == null || password.length == 0) {
      return;
    }

    _loginModel.login(_globalUserModel).then((res) => _onLoginSuccess(res));
  }

  /// 登录结果处理
  void _onLoginSuccess(DataResult res) {
    final LoginPageModel _loginModel = Provider.of<LoginPageModel>(context);

    if (res != null && res.result) {
      // 清除登录信息
      _loginModel.updateTextField("", userNameController);
      _loginModel.updateTextField("", passwordController);
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
