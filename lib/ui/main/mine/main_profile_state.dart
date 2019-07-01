import 'package:flutter_rhine/common/common.dart';

abstract class MainProfileState {
  final User user;

  MainProfileState(this.user);
}

class MainProfileIdleState extends MainProfileState {
  MainProfileIdleState() : super(null);
}

class MainProfileInitSuccessState extends MainProfileState {
  MainProfileInitSuccessState(User user)
      : assert(user != null),
        super(user);
}
