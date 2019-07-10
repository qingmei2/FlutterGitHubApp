import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_rhine/common/model/user.dart';
import 'package:flutter_rhine/repository/repository.dart';

import 'login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;

  LoginBloc(this.userRepository) : assert(userRepository != null);

  @override
  LoginState get initialState => LoginState.initial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is InitialEvent) {
      if (event.shouldAutoLogin) {
        final bool hasAutoLoginInfo = await userRepository.hasAutoLoginInfo();
        if (hasAutoLoginInfo) {
          final List<String> info = await userRepository.fetchAutoLoginInfo();
          final String username = info[0];
          final String password = info[1];

          // 本地存有登录信息，自动登录
          yield* _loginStateStream(username, password);
        } else {
          // 没有登录信息，手动登录
          yield _autoLoginFailureState();
        }
      } else {
        // 需要用户手动登录
        yield _autoLoginFailureState();
      }
    }

    if (event is LoginClickedEvent) {
      yield* _loginStateStream(event.username, event.password);
    }
  }

  /// 用户登录
  /// [username] 用户名
  /// [password] 用户密码
  Stream<LoginState> _loginStateStream(
      final String username, final String password) async* {
    yield _autoLoginLoadingState(username, password);
    final DataResult<User> loginResult =
        await userRepository.login(username, password);

    if (loginResult?.result ?? false) {
      yield _loginSuccessState(username, password);
    } else {
      yield _loginFailureState(username, password);
    }
  }

  LoginState _autoLoginFailureState() {
    return LoginNormal(username: '', password: '');
  }

  LoginState _autoLoginLoadingState(
      final String username, final String password) {
    return LoginLoading(username: username, password: password);
  }

  LoginState _loginSuccessState(final String username, final String password) {
    return LoginSuccess(username, password);
  }

  LoginState _loginFailureState(final String username, final String password) {
    return LoginFailure(username, password, '登录失败');
  }
}
