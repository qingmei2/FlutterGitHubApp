import 'package:flutter_rhine/common/common.dart';

import 'login.dart';

final loginReducer = combineReducers<LoginState>([
  TypedReducer<LoginState, LoginLoadingAction>(_loginLoading),
  TypedReducer<LoginState, LoginSuccessAction>(_loginSuccess),
  TypedReducer<LoginState, LoginFailureAction>(_loginFailure),
]);

LoginState _loginLoading(LoginState state, LoginLoadingAction action) {
  return state.copyWith(
      isLoginSuccess: null, isLoginCancel: null, isLoading: true);
}

LoginState _loginSuccess(LoginState state, LoginSuccessAction action) {
  return state.copyWith(
      isLoginSuccess: true, isLoginCancel: null, isLoading: false);
}

LoginState _loginFailure(LoginState state, LoginFailureAction action) {
  return state.copyWith(isLoading: false);
}
