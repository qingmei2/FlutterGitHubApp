import 'package:bloc/bloc.dart';

import 'main.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  @override
  MainPageState get initialState => MainPageState.initial();

  @override
  Stream<MainPageState> mapEventToState(MainPageEvent event) async* {
    if (event is MainChoiceBottomTabEvent) {
      yield MainNormalState(event.newTabIndex);
    }

    if (event is MainSwipeViewPagerEvent) {
      yield MainNormalState(event.currentItem);
    }
  }
}
