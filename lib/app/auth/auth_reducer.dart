import 'package:flutter_rhine/app/auth/auth_action.dart';
import 'package:flutter_rhine/common/common.dart';

final appAuthReducer = combineReducers<AppUser>([
  TypedReducer<AppUser, AuthenticationSuccessAction>(_authenticationSuccess),
  TypedReducer<AppUser, AuthenticationCancelAction>(_authenticationClear),
  TypedReducer<AppUser, AuthenticationClearAction>(_authenticationFailure),
]);

AppUser _authenticationSuccess(
  AppUser user,
  AuthenticationSuccessAction action,
) {
  return AppUser(user: action.user, token: action.token);
}

AppUser _authenticationFailure(
  AppUser user,
  AuthenticationClearAction action,
) {
  return AppUser(user: null, token: null);
}

AppUser _authenticationClear(
  AppUser user,
  AuthenticationCancelAction action,
) {
  return AppUser(user: null, token: null);
}
