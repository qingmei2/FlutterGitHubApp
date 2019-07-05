import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rhine/common/common.dart';
import 'package:flutter_rhine/ui/login/login_middleware.dart';
import 'package:flutter_rhine/ui/login/login_page.dart';
import 'package:flutter_rhine/ui/main/main_page.dart';

import 'app/app_reducer.dart';
import 'ui/login/login.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

  runApp(App());
}

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserRepository userRepository = UserRepository();

    final Store<AppState> appStore = Store<AppState>(
      appReducer,
      initialState: AppState(
        loginState: LoginState.initial(),
      ),
      middleware: [
        EpicMiddleware<AppState>(LoginEpic(userRepository)),
      ],
    );

    return StoreProvider<AppState>(
      store: appStore,
      child: MaterialApp(
        title: 'Flutter-Rhine',
        debugShowCheckedModeBanner: Config.DEBUG,
        theme: ThemeData(
          primaryColor: colorPrimary,
          primaryColorDark: colorPrimaryDark,
          accentColor: colorAccent,
        ),
        routes: {
          AppRoutes.login: (context) {
            return _loginPage(appStore, userRepository);
          },
          AppRoutes.main: (context) {
            return MainPage(userRepository: userRepository);
          },
        },
        home: _loginPage(appStore, userRepository),
      ),
    );
  }

  Widget _loginPage(
    final Store<AppState> appStore,
    final UserRepository userRepository,
  ) {
    return LoginPage(
      userRepository: userRepository,
      loginSuccessCallback: (
        final BuildContext context,
        final User user,
        final String token,
      ) {
        toast('登录成功，跳转主页面');

        Navigator.pop(context);
        Navigator.pushNamed(context, AppRoutes.main);
        appStore.dispatch(AuthenticationSuccessAction(user, token));
      },
      loginCancelCallback: (
        final BuildContext context,
      ) {
        toast('用户取消了登录');
        appStore.dispatch(AuthenticationCancelAction());
      },
    );
  }
}
