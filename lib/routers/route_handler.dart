import 'package:fluro/fluro.dart';
import 'package:flutter_rhine/pages/home/main_page.dart';
import 'package:flutter_rhine/pages/login/login_page.dart';

final Handler loginHandler = Handler(
  handlerFunc: (context, params) => LoginPage(),
);

final Handler mainHandler = Handler(
  handlerFunc: (context, params) => MainPage(),
);
