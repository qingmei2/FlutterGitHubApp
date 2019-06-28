import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rhine/common/constants/assets.dart';
import 'package:flutter_rhine/common/constants/colors.dart';
import 'package:flutter_rhine/common/widget/global_progress_bar.dart';
import 'package:flutter_rhine/repository/others/dao_result.dart';
import 'package:flutter_rhine/repository/repository.dart';

import 'login.dart';

class LoginPage extends StatelessWidget {
  static final String path = 'login_page';

  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: BlocProvider(
        builder: (context) => LoginBloc(userRepository),
        child: Container(
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
                BlocListener<LoginEvent, LoginState>(
                  bloc: BlocProvider.of<LoginBloc>(context),
                  listener: (context, state) {
                    ProgressBar(
                      visibility: state.isLoading,
                    );
                  },
                ),
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
  Widget _usernameInput(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);
    final state = bloc.currentState;
    userNameController.text = state.username;

    return BlocListener<LoginEvent, LoginState>(
      bloc: bloc,
      listener: (context, state) {
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
  Widget _passwordInput(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);
    passwordController.text = bloc.currentState.password;
    return BlocListener<LoginEvent, LoginState>(
      bloc: bloc,
      listener: (context, state) {
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
  Widget _signInButton(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);
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

  /// 登录结果处理
  void _onLoginSuccess(DataResult res) {
    // 登录成功，跳转主页面
//    Future.delayed(const Duration(seconds: 1), () {
//      Navigator.pop(context);
//      Application.router.navigateTo(context, MainPage.path);
//      return true;
//    });
  }
}
