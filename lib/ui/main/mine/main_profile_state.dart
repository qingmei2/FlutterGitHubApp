import 'package:flutter_rhine/common/common.dart';

class MainProfileState {}

abstract class MainProfileStates {
  final User user;

  MainProfileStates(this.user);
}

class MainProfileIdleState extends MainProfileStates {
  MainProfileIdleState() : super(null);
}

class MainProfileInitSuccessState extends MainProfileStates {
  MainProfileInitSuccessState(User user)
      : assert(user != null),
        super(user);
}
