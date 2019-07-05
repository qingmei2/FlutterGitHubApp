import 'package:flutter_rhine/common/common.dart';
import 'package:flutter_rhine/ui/login/login_state.dart';

@immutable
class AppState {
  final AppUser appUser; // 用户的信息数据
  final LoginState loginState; // 登录页面

  AppState({this.appUser, this.loginState});

  AppState copyWith({
    final AppUser appUser,
    final LoginState loginState,
  }) {
    return AppState(
      appUser: appUser ?? this.appUser,
      loginState: loginState ?? this.loginState,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          appUser == other.appUser &&
          loginState == other.loginState;

  @override
  int get hashCode => appUser.hashCode ^ loginState.hashCode;

  @override
  String toString() {
    return 'AppState{appUser: $appUser, loginState: $loginState}';
  }
}
