import 'package:flutter_rhine/common/common.dart';

import 'main_issues.dart';

final mainIssuesReducer = combineReducers<MainIssuesState>([
  TypedReducer<MainIssuesState, MainIssuesFirstLoadingAction>(
      _mainIssuesFirstLoadingReducer),
  TypedReducer<MainIssuesState, MainIssuesEmptyAction>(_mainIssuesEmptyReducer),
  TypedReducer<MainIssuesState, MainIssuesPageLoadSuccess>(
      _mainIssuesPageLoadSuccessReducer),
  TypedReducer<MainIssuesState, MainIssuesPageLoadFailure>(
      _mainIssuesPageLoadFailureReducer),
]);

MainIssuesState _mainIssuesFirstLoadingReducer(
  MainIssuesState pre,
  MainIssuesFirstLoadingAction action,
) {
  return pre.copyWith(isLoading: true, error: null);
}

MainIssuesState _mainIssuesEmptyReducer(
  MainIssuesState pre,
  MainIssuesEmptyAction action,
) {
  return pre.copyWith(isLoading: false, error: Errors.emptyListException());
}

MainIssuesState _mainIssuesPageLoadSuccessReducer(
  MainIssuesState pre,
  MainIssuesPageLoadSuccess action,
) {
  return pre.copyWith(
    isLoading: false,
    issues: action.issues,
    currentPage: action.currentPage,
  );
}

MainIssuesState _mainIssuesPageLoadFailureReducer(
  MainIssuesState pre,
  MainIssuesPageLoadFailure action,
) {
  return pre.copyWith(
    isLoading: false,
    error: action.exception,
  );
}
