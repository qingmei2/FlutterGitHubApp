import 'package:bloc/bloc.dart';
import 'package:flutter_rhine/ui/main/main.dart';

class MainProfileBloc extends Bloc<MainProfileEvent, MainProfileStates> {
  @override
  MainProfileStates get initialState => MainProfileIdleState();

  @override
  Stream<MainProfileStates> mapEventToState(MainProfileEvent event) async* {
    if (event is MainProfileInitialEvent) {
      yield MainProfileInitSuccessState(event.user);
    }
  }
}
