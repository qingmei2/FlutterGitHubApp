import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rhine/common/common.dart';
import 'package:flutter_rhine/ui/login/login_page.dart';
import 'package:flutter_rhine/ui/main/main_page.dart';

import 'blocs/auth.dart';
import 'blocs/auth_bloc.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

  final UserRepository userRepository = UserRepository();

  runApp(BlocProvider<AuthenticationBloc>(
    builder: (context) =>
        AuthenticationBloc(userRepository)..dispatch(AppStart()),
    child: App(userRepository: userRepository),
  ));
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter-Rhine',
      debugShowCheckedModeBanner: Config.DEBUG,
      theme: ThemeData(
        primaryColor: colorPrimary,
        primaryColorDark: colorPrimaryDark,
        accentColor: colorAccent,
      ),
      routes: {
        AppRoutes.login: (context) {
          return LoginPage(userRepository: userRepository);
        },
        AppRoutes.main: (context) {
          return MainPage(userRepository: userRepository);
        }
      },
    );
  }
}
