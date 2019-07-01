import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rhine/routers/application.dart';
import 'package:flutter_rhine/routers/routes.dart';
import 'package:flutter_rhine/ui/login/login_page.dart';

import 'blocs/auth.dart';
import 'blocs/auth_bloc.dart';
import 'common/constants/constants.dart';
import 'repository/repository.dart';

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
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return MaterialApp(
      title: 'Flutter-Rhine',
      onGenerateRoute: Application.router.generator,
      debugShowCheckedModeBanner: Config.DEBUG,
      theme: ThemeData(
        primaryColor: colorPrimary,
        primaryColorDark: colorPrimaryDark,
        accentColor: colorAccent,
      ),
      home: LoginPage(userRepository: userRepository),
    );
  }
}
