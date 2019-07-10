import 'package:flutter_rhine/common/common.dart';

import 'main_repo.dart';

final mainRepoReducer = combineReducers<MainReposState>([
  TypedReducer<MainReposState, MainReposLoadingAction>(
      _mainReposLoadingReducer),
  TypedReducer<MainReposState, MainReposEmptyAction>(_mainReposEmptyReducer),
  TypedReducer<MainReposState, MainReposPageLoadSuccessAction>(
      _mainReposPageLoadSuccessReducer),
  TypedReducer<MainReposState, MainReposPageLoadFailureAction>(
      _mainReposPageLoadFailureReducer),
]);

MainReposState _mainReposLoadingReducer(
  final MainReposState pre,
  final MainReposLoadingAction action,
) {
  return pre.copyWith(
    isLoading: true,
    error: null,
  );
}

MainReposState _mainReposEmptyReducer(
  final MainReposState pre,
  final MainReposEmptyAction action,
) {
  return pre.copyWith(
    isLoading: false,
    repos: [],
    error: Errors.emptyListException(),
  );
}

MainReposState _mainReposPageLoadSuccessReducer(
  final MainReposState pre,
  final MainReposPageLoadSuccessAction action,
) {
  return pre.copyWith(
    isLoading: false,
    repos: action.repos,
    sortType: action.sortType,
    currentPage: action.currentPage,
    error: null,
  );
}

MainReposState _mainReposPageLoadFailureReducer(
  final MainReposState pre,
  final MainReposPageLoadFailureAction action,
) {
  return pre.copyWith(
    isLoading: false,
    error: action.exception,
  );
}
