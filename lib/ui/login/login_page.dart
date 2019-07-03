import 'package:flutter/material.dart';
import 'package:flutter_rhine/common/common.dart';
import 'package:flutter_rhine/repository/repository.dart';

import 'login.dart';

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
    final Store<LoginState> store = Store<LoginState>(
      loginReducer,
      initialState: LoginState.initial(),
      middleware: [EpicMiddleware<LoginState>(LoginEpic(userRepository))],
      distinct: true,
    );

    return StoreProvider(
      store: store,
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
        body: LoginForm(),
      ),
    );
  }
}

typedef LoginSuccessCallback(final User user, final String token);

typedef LoginCancelCallback();
