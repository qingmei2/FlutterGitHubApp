import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rhine/pages/login/login_page.dart';
import 'package:flutter_rhine/provider/login/login_provider.dart';
import 'package:flutter_rhine/provider/main/main_provider.dart';
import 'package:flutter_rhine/routers/application.dart';
import 'package:flutter_rhine/routers/routes.dart';
import 'package:provide/provide.dart';

import 'constants/colors.dart';

void main() {
  var loginProvide = LoginProvider();
  var mainProvide = MainPageProvider();
  var providers = Providers();

  providers..provide(Provider<LoginProvider>.value(loginProvide));
  providers..provide(Provider<MainPageProvider>.value(mainProvide));

  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
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
