import 'package:flutter_rhine/common/common.dart';

import 'login.dart';

class LoginEpic implements EpicClass<LoginState> {
  final UserRepository userRepository;

  LoginEpic(this.userRepository) : assert(userRepository != null);

  @override
  Stream call(Stream actions, EpicStore<LoginState> store) {
    return Observable(actions).flatMap((dynamic action) {
      if (action is InitialAction) {
        return _loginInitial(action.shouldAutoLogin);
      }
      if (action is LoginClickedAction) {
        return _loginClicked(action.username, action.password);
      }
    });
  }

  /// 用户进入界面初始化
  /// [shouldAutoLogin] 是否自动登录
  Stream<LoginAction> _loginInitial(final bool shouldAutoLogin) async* {
    if (shouldAutoLogin) {
      final bool hasAutoLoginInfo = await userRepository.hasAutoLoginInfo();
      if (hasAutoLoginInfo) {
        final List<String> info = await userRepository.fetchAutoLoginInfo();
        final String username = info[0];
        final String password = info[1];

        // 本地存有登录信息，自动登录
        yield* _loginStateStream(username, password);
      } else {
        // 没有登录信息，手动登录
        yield _loginFailure();
      }
    } else {
      // 需要用户手动登录
      yield _loginFailure();
    }
  }

  /// 用户点击登录按钮
  /// [username] 用户名
  /// [password] 用户密码
  Stream<LoginAction> _loginClicked(
    final String username,
    final String password,
  ) async* {
    yield* _loginStateStream(username, password);
  }

  /// 用户登录
  /// [username] 用户名
  /// [password] 用户密码
  Stream<LoginAction> _loginStateStream(
    final String username,
    final String password,
  ) async* {
    yield LoginLoadingAction();
    final DataResult<User> loginResult =
        await userRepository.login(username, password);

    if (loginResult.result) {
      final User user = loginResult.data;
      yield LoginSuccessAction(user, user.token);
    } else {
      yield _loginFailure();
    }
  }

  LoginFailureAction _loginFailure() {
    return LoginFailureAction('登录失败');
  }
}
