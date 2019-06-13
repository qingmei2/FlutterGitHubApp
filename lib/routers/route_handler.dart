import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rhine/pages/login/login_page.dart';

final Handler homeHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
      LoginPage(),
);
