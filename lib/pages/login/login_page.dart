import 'package:flutter/material.dart';
import 'package:flutter_rhine/constants/assets.dart';
import 'package:flutter_rhine/constants/colors.dart';

class LoginPage extends StatelessWidget {
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
          child: Column(
            children: <Widget>[
              _loginTitle(),
              _usernameInput(),
              _passwordInput(),
              _signInButton()
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
  Widget _usernameInput() => Container(
        margin: EdgeInsets.only(top: 24.0),
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            labelText: 'Username or email address',
          ),
        ),
      );

  /// 密码输入框
  Widget _passwordInput() => Container(
        margin: EdgeInsets.only(top: 8.0),
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            labelText: 'Password',
          ),
        ),
      );

  /// 登录按钮
  Widget _signInButton() => Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 32.0),
        width: double.infinity,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: double.infinity,
            minHeight: 50.0,
          ),
          child: FlatButton(
            onPressed: () {},
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
