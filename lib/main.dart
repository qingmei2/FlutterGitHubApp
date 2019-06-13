import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rhine/pages/login/login_page.dart';
import 'package:flutter_rhine/provide/login.dart';
import 'package:flutter_rhine/routers/application.dart';
import 'package:flutter_rhine/routers/routes.dart';
import 'package:provide/provide.dart';

import 'constants/colors.dart';

void main() {
  var loginProvide = LoginProvide();
  var providers = Providers();

  providers..provide(Provider<LoginProvide>.value(loginProvide));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return MaterialApp(
      title: 'Flutter-Rhine',
      onGenerateRoute: Application.router.generator,
      theme: ThemeData(
        primaryColor: colorPrimary,
        primaryColorDark: colorPrimaryDark,
        accentColor: colorAccent,
      ),
      home: LoginPage(),
    );
  }
}
