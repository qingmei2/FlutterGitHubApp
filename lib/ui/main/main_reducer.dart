import 'package:flutter_rhine/common/common.dart';
import 'package:flutter_rhine/ui/main/home/main_events_reducer.dart';

import 'main.dart';

final mainPageReducer = combineReducers<MainPageState>([
  TypedReducer<MainPageState, MainSwipeViewPagerAction>(
      _mainSwipeViewPagerReducer),
  TypedReducer<MainPageState, MainEventsAction>(_mainEventsReducer),
  TypedReducer<MainPageState, MainProfileAction>(_mainProfileReducer),
]);

MainPageState _mainSwipeViewPagerReducer(
  MainPageState preState,
  MainSwipeViewPagerAction action,
) {
  return preState.currentPageIndex == action.currentItem
      ? preState
      : preState.copyWith(currentPageIndex: action.currentItem);
}

MainPageState _mainProfileReducer(
  MainPageState preState,
  MainProfileAction action,
) {
  final preProfileState = preState.profileState;
  final newProfileState = mainProfileReducer(preProfileState, action);
  return preState.copyWith(profileState: newProfileState);
}

MainPageState _mainEventsReducer(
  MainPageState preState,
  MainEventsAction action,
) {
  final preProfileState = preState.eventState;
  final newProfileState = mainEventsReducer(preProfileState, action);
  return preState.copyWith(eventState: newProfileState);
}
