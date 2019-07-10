import 'package:flutter_rhine/common/common.dart';

import 'main_issues.dart';

class MainIssuesEpic implements EpicClass<AppState> {
  @override
  Stream call(Stream actions, EpicStore<AppState> store) {
    return Observable.merge([
      Observable(actions).ofType(TypeToken<MainIssuesInitialAction>()).flatMap(
          (action) => _pagingRequestStream(newPageIndex: 1, previousList: [])),
      Observable(actions)
          .ofType(TypeToken<MainIssuesLoadNextPageAction>())
          .flatMap((action) => _pagingRequestStream(
                newPageIndex: action.currentPage + 1,
                previousList: action.previousList,
              )),
    ]);
  }

  /// 分页网络请求
  /// [newPageIndex] 新的分页索引
  /// [sort] 排序规则,[IssuesRepository.SORT_CREATED]、[IssuesRepository.SORT_UPDATED]、[IssuesRepository.SORT_COMMENTS]
  /// [state] issue状态,[IssuesRepository.STATE_OPEN]、[IssuesRepository.STATE_CLOSED]、[IssuesRepository.STATE_ALL]
  /// [previousList] 之前的列表数据
  Stream<MainIssuesAction> _pagingRequestStream({
    final int newPageIndex,
    final List<Issue> previousList,
    final String sort = IssuesRepository.SORT_UPDATED,
    final String state = IssuesRepository.STATE_OPEN,
  }) async* {
    final isFirstPage = newPageIndex == 1;
    if (isFirstPage) {
      yield MainIssuesFirstLoadingAction();
    }

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
        if (isFirstPage) {
          yield MainIssuesEmptyAction();
        } else {
          yield MainIssuesPageLoadFailure(Errors.noMoreDataException());
        }
      }
    } else {
      if (isFirstPage) {
        yield MainIssuesPageLoadFailure(
            Errors.networkException(message: '网络请求失败'));
      } else {
        yield MainIssuesPageLoadFailure(
            Errors.networkException(message: '请求更多数据失败'));
      }
    }
  }
}
