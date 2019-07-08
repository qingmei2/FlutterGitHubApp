import 'package:flutter_rhine/common/common.dart';

import 'main_events.dart';

final mainEventsReducer = combineReducers<MainEventsState>([
  TypedReducer<MainEventsState, MainEventsFirstLoadingAction>(
      _mainEventsFirstLoadingReducer),
  TypedReducer<MainEventsState, MainEventsPageLoadSuccessAction>(
      _mainEventsPageLoadSuccessAction),
  TypedReducer<MainEventsState, MainEventPageLoadFailureAction>(
      _mainEventPageLoadFailureAction),
]);

MainEventsState _mainEventsFirstLoadingReducer(
  MainEventsState preState,
  MainEventsFirstLoadingAction action,
) {
  return preState.copyWith(
    isLoading: true,
    error: null,
  );
}

MainEventsState _mainEventsPageLoadSuccessAction(
  MainEventsState preState,
  MainEventsPageLoadSuccessAction action,
) {
  return preState.copyWith(
    isLoading: false,
    currentPage: action.currentPage,
    events: action.events,
    error: null,
  );
}

MainEventsState _mainEventPageLoadFailureAction(
  MainEventsState preState,
  MainEventPageLoadFailureAction action,
) {
  return preState.copyWith(
    isLoading: false,
    error: action.exception,
  );
}
