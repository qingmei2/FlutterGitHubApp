import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rhine/pages/home/main_page.dart';
import 'package:flutter_rhine/pages/login/login_page.dart';
import 'package:flutter_rhine/routers/route_handler.dart';

class Routes {
  static String root = '/';
  static String detailPage = '/detail';

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print('Error ===> ROUTE WAS NOT FOUND');
      },
    );

    router
      ..define(LoginPage.path, handler: loginHandler)
      ..define(MainPage.path, handler: mainHandler);
  }
}
