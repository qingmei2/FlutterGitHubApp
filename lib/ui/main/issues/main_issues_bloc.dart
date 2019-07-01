import 'package:bloc/bloc.dart';
import 'package:flutter_rhine/common/common.dart';

import 'main_issues.dart';

class MainIssuesBloc extends Bloc<MainIssuesEvent, MainIssuesState> {
  @override
  MainIssuesState get initialState => MainIssuesEmptyState();

  @override
  Stream<MainIssuesState> mapEventToState(MainIssuesEvent event) async* {
    final MainIssuesState nowState = currentState;
    if (event is MainIssuesInitialEvent) {
      yield MainIssuesFirstLoading();
      yield* _pagingRequestStream(
        newPageIndex: 1,
        previousList: [],
      );
    }

    if (event is MainIssuesLoadNextPageEvent) {
      final int newPage = nowState.currentPage + 1;
      final List<Issue> oldList = nowState.issues;
      yield* _pagingRequestStream(
        newPageIndex: newPage,
        previousList: oldList,
        sort: nowState.listSort,
        state: nowState.listState,
      );
    }
  }

  /// 分页网络请求
  /// [newPageIndex] 新的分页索引
  /// [sort] 排序规则,[IssuesRepository.SORT_CREATED]、[IssuesRepository.SORT_UPDATED]、[IssuesRepository.SORT_COMMENTS]
  /// [state] issue状态,[IssuesRepository.STATE_OPEN]、[IssuesRepository.STATE_CLOSED]、[IssuesRepository.STATE_ALL]
  /// [previousList] 之前的列表数据
  Stream<MainIssuesState> _pagingRequestStream({
    final int newPageIndex,
    final List<Issue> previousList,
    final String sort = IssuesRepository.SORT_UPDATED,
    final String state = IssuesRepository.STATE_OPEN,
  }) async* {
    final DataResult<List<Issue>> result = await IssuesRepository.fetchIssues(
      sort: sort,
      state: state,
      page: newPageIndex,
    );

    if (result.result) {
      if (result.data.length > 0) {
        final List<Issue> eventList = result.data;
        previousList.addAll(eventList);

        yield MainIssuesPageLoadSuccess(
          issues: previousList,
          currentPage: newPageIndex,
        );
      } else {
        if (newPageIndex == 1) {
          yield MainIssuesEmptyState();
        } else {
          yield MainIssuesPageLoadFailure(
            currentPage: newPageIndex,
            issues: previousList,
            errorMessage: '没有更多了',
          );
        }
      }
    } else {
      if (newPageIndex == 1) {
        yield MainIssuesPageLoadFailure(
            currentPage: 1, errorMessage: '初始化网络请求失败');
      } else {
        yield MainIssuesPageLoadFailure(
          currentPage: newPageIndex,
          issues: previousList,
          errorMessage: '请求更多数据失败',
        );
      }
    }
  }
}
