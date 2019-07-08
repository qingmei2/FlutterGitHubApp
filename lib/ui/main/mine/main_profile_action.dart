import 'package:flutter_rhine/common/common.dart';

abstract class MainProfileAction {}

class MainProfileInitialAction extends MainProfileAction {
  final User user;

  MainProfileInitialAction(this.user) : assert(user != null);
}
