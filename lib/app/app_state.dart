import 'package:flutter_rhine/common/common.dart';

@immutable
class AppState {
  /// 用户的信息数据
  final AppUser appUser;

  AppState({
    this.appUser,
  });

  AppState copyWith({
    AppUser appUser,
  }) {
    return AppState(
      appUser: appUser ?? this.appUser,
    );
  }

  @override
  String toString() {
    return 'AppState{appUser: $appUser}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          appUser == other.appUser;

  @override
  int get hashCode => appUser.hashCode;
}
