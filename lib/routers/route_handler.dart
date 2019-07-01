import 'package:fluro/fluro.dart';
import 'package:flutter_rhine/repository/repository.dart';
import 'package:flutter_rhine/ui/login/login_page.dart';
import 'package:flutter_rhine/ui/main/main_page.dart';

Handler fetchLoginHandler(UserRepository userRepository) {
  return Handler(
    handlerFunc: (context, params) => LoginPage(userRepository: userRepository),
  );
}

Handler fetchMainHandler(UserRepository userRepository) {
  return Handler(
    handlerFunc: (context, params) => MainPage(userRepository: userRepository),
  );
}
