import 'package:flutter_rhine/common/common.dart';

import 'main.dart';

final mainPageReducer = combineReducers<MainPageState>([
  TypedReducer<MainPageState, MainSwipeViewPagerAction>(
      _mainSwipeViewPagerReducer),
]);

MainPageState _mainSwipeViewPagerReducer(
  MainPageState preState,
  MainSwipeViewPagerAction action,
) {
  return preState.currentPageIndex == action.currentItem
      ? preState
      : preState.copyWith(currentPageIndex: action.currentItem);
}
