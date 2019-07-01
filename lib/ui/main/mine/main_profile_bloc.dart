import 'package:bloc/bloc.dart';
import 'package:flutter_rhine/ui/main/main.dart';

class MainProfileBloc extends Bloc<MainProfileEvent, MainProfileState> {
  @override
  MainProfileState get initialState => MainProfileIdleState();

  @override
  Stream<MainProfileState> mapEventToState(MainProfileEvent event) async* {
    if (event is MainProfileInitialEvent) {
      yield MainProfileInitSuccessState(event.user);
    }
  }
}
