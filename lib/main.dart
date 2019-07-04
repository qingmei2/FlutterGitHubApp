import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rhine/common/common.dart';
import 'package:flutter_rhine/ui/login/login_page.dart';
import 'package:flutter_rhine/ui/main/main_page.dart';

import 'app/app_reducer.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

  runApp(App());
}

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  final Store<AppState> appStore = Store<AppState>(appReducer);

  @override
  Widget build(BuildContext context) {
    final UserRepository userRepository = UserRepository();
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
            return LoginPage(
              userRepository: userRepository,
              loginSuccessCallback: (final User user, final String token) {
                print('main_loginSuccessCallback');
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.main);
//                appStore.dispatch(AuthenticationSuccessAction(user, token));
              },
              loginCancelCallback: () {
                print('loginCancelCallback');
//                appStore.dispatch(AuthenticationCancelAction());
              },
            );
          },
          AppRoutes.main: (context) {
            return MainPage(userRepository: userRepository);
          }
        },
      ),
    );
  }
}
