import 'package:flutter_rhine/common/common.dart';

import '../app_reducer.dart';

abstract class AuthenticationAction extends AppAction {}

class AuthenticationSuccessAction extends AuthenticationAction {
  final User user;
  final String token;

  AuthenticationSuccessAction(this.user, this.token) : assert(user != null);
}

class AuthenticationFailureAction extends AuthenticationAction {}

class AuthenticationCancelAction extends AuthenticationAction {}

class AuthenticationClearAction extends AuthenticationAction {}
