import 'package:flutter_rhine/common/common.dart';

abstract class MainProfileEvent {}

class MainProfileInitialEvent extends MainProfileEvent {
  final User user;

  MainProfileInitialEvent(this.user) : assert(user != null);
}
