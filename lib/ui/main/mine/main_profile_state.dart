import 'package:flutter_rhine/common/common.dart';

@immutable
class MainProfileState {
  final User user;

  MainProfileState({
    this.user,
  });

  @override
  String toString() {
    return 'MainProfileState{user: $user}';
  }

  MainProfileState copyWith({
    final User user,
  }) {
    return MainProfileState(
      user: user ?? this.user,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainProfileState &&
          runtimeType == other.runtimeType &&
          user == other.user;

  @override
  int get hashCode => user.hashCode;
}
