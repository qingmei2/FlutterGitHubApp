import 'package:flutter_rhine/app/auth/auth_reducer.dart';
import 'package:flutter_rhine/common/common.dart';
import 'package:flutter_rhine/ui/login/login_reducer.dart';

abstract class AppAction {}

AppState appReducer(AppState preState, dynamic action) {
  return AppState(
    appUser: appAuthReducer(preState.appUser, action),
    loginState: loginReducer(preState.loginState, action),
  );
}
