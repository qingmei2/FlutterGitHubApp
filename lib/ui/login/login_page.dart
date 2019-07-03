import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rhine/repository/repository.dart';

import 'login.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
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
        body: LoginForm(),
      ),
    );
  }
}
