import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rhine/common/constants/config.dart';
import 'package:flutter_rhine/ui/login/login_page.dart';
import 'package:flutter_rhine/ui/login/login_page_model.dart';
import 'package:flutter_rhine/ui/main/main_page_model.dart';
import 'package:flutter_rhine/routers/application.dart';
import 'package:flutter_rhine/routers/routes.dart';
import 'package:provider/provider.dart';

import 'common/constants/colors.dart';
import 'common/providers/global_user_model.dart';

import 'package:flutter/foundation.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

  var globalUserInfoModel = GlobalUserModel();

  var mainPageModel = MainPageModel();
  var loginModel = LoginPageModel();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: globalUserInfoModel),
      ChangeNotifierProvider.value(value: mainPageModel),
      ChangeNotifierProvider.value(value: loginModel),
    ],
    child: MyApp(),
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
      debugShowCheckedModeBanner: Config.DEBUG,
      theme: ThemeData(
        primaryColor: colorPrimary,
        primaryColorDark: colorPrimaryDark,
        accentColor: colorAccent,
      ),
      home: LoginPage(),
    );
  }
}
