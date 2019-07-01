import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rhine/repository/repository.dart';
import 'package:flutter_rhine/routers/route_handler.dart';
import 'package:flutter_rhine/ui/login/login_page.dart';
import 'package:flutter_rhine/ui/main/main_page.dart';

class Routes {
  static String root = '/';
  static String detailPage = '/detail';

  static void configureRoutes(Router router, UserRepository userRepository) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print('Error ===> ROUTE WAS NOT FOUND');
      },
    );

    router
      ..define(LoginPage.path, handler: fetchLoginHandler(userRepository))
      ..define(MainPage.path, handler: fetchMainHandler(userRepository));
  }
}
