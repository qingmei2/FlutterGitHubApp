import 'package:flutter_rhine/common/common.dart';
import 'package:flutter_rhine/ui/login/login_state.dart';
import 'package:flutter_rhine/ui/main/main.dart';

@immutable
class AppState {
  final AppUser appUser; // 用户的信息数据
  final LoginState loginState; // 登录页面
  final MainPageState mainState; // 主页面

  AppState({this.appUser, this.loginState, this.mainState});

  factory AppState.initial() {
    return AppState(
      loginState: LoginState.initial(),
      mainState: MainPageState.initial(),
    );
  }

  AppState copyWith({
    final AppUser appUser,
    final LoginState loginState,
    final MainPageState mainState,
  }) {
    return AppState(
      appUser: appUser ?? this.appUser,
      loginState: loginState ?? this.loginState,
      mainState: mainState ?? this.mainState,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          appUser == other.appUser &&
          loginState == other.loginState &&
          mainState == other.mainState;

  @override
  int get hashCode =>
      appUser.hashCode ^ loginState.hashCode ^ mainState.hashCode;

  @override
  String toString() {
    return 'AppState{appUser: $appUser, loginState: $loginState, mainState: $mainState}';
  }
}
