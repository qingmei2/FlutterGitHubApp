import 'package:flutter_rhine/common/common.dart';

import 'login.dart';

final loginReducer = combineReducers<LoginState>([
  TypedReducer<LoginState, LoginClickedAction>(_clickLogin),
  TypedReducer<LoginState, AutoLoginInfoGetAction>(_autoLogin),
  TypedReducer<LoginState, LoginLoadingAction>(_loginLoading),
  TypedReducer<LoginState, LoginSuccessAction>(_loginSuccess),
  TypedReducer<LoginState, LoginFailureAction>(_loginFailure),
  TypedReducer<LoginState, LoginDisposeAction>(_loginDispose),
]);

LoginState _clickLogin(LoginState state, LoginClickedAction action) {
  return state.copyWith(
    username: action.username,
    password: action.password,
    user: null,
    isLoginCancel: null,
    isLoading: true,
    error: null,
  );
}

LoginState _autoLogin(LoginState state, AutoLoginInfoGetAction action) {
  return state.copyWith(
    username: action.username,
    password: action.password,
    user: null,
    isLoginCancel: null,
    isLoading: true,
    error: null,
  );
}

LoginState _loginLoading(LoginState state, LoginLoadingAction action) {
  return state.copyWith(
      user: null, isLoginCancel: null, isLoading: true, error: null);
}

LoginState _loginSuccess(LoginState state, LoginSuccessAction action) {
  return state.copyWith(
      user: action.user, isLoginCancel: null, isLoading: false, error: null);
}

LoginState _loginFailure(LoginState state, LoginFailureAction action) {
  return state.copyWith(isLoading: false, error: action.exception);
}

LoginState _loginDispose(LoginState state, LoginDisposeAction action) {
  return state.copyWith(
    user: null,
    isLoginCancel: false,
    isLoading: false,
    error: null,
    username: '',
    password: '',
  );
}
