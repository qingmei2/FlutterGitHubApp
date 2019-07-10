import 'package:flutter_rhine/common/common.dart';

import 'main_repo.dart';

class MainRepoEpic implements EpicClass<AppState> {
  @override
  Stream call(Stream actions, EpicStore<AppState> store) {
    return Observable.merge([
      Observable(actions).ofType(TypeToken<MainReposInitialAction>()).flatMap(
          (action) =>
              _pagingRequestStream(1, [], action.username, action.sortType)),
      Observable(actions)
          .ofType(TypeToken<MainReposChangeFilterAction>())
          .flatMap((action) =>
              _pagingRequestStream(1, [], action.username, action.sortType)),
      Observable(actions)
          .ofType(TypeToken<MainReposLoadNextPageAction>())
          .flatMap((action) => _pagingRequestStream(action.currentPageIndex,
              action.preList, action.username, action.sortType)),
    ]);
  }

  /// 分页网络请求
  /// [newPageIndex] 新的分页索引
  /// [previousList] 之前的列表数据
  /// [username]     用户名
  /// [sort]         排序规则，应使用[UserRepoRepository.SORT_UPDATED]、[UserRepoRepository.SORT_CREATED]、[UserRepoRepository.SORT_LETTER]
  Stream<MainReposAction> _pagingRequestStream(
    int newPageIndex,
    List<Repo> previousList,
    String username,
    String sort,
  ) async* {
    final isFirstPage = newPageIndex == 1;
    if (isFirstPage) {
      yield MainReposLoadingAction();
    }

    final DataResult<List<Repo>> result = await UserRepoRepository.fetchRepos(
      username: username,
      sort: sort,
      pageIndex: newPageIndex,
    );

    if (result.result) {
      if (result.data.length > 0) {
        final List<Repo> eventList = result.data;
        previousList.addAll(eventList);
        yield MainReposPageLoadSuccessAction(
          repos: previousList,
          currentPage: newPageIndex,
          sortType: sort,
        );
      } else {
        if (isFirstPage) {
          yield MainReposEmptyAction();
        } else {
          yield MainReposPageLoadFailureAction(Errors.noMoreDataException());
        }
      }
    } else {
      if (isFirstPage) {
        yield MainReposPageLoadFailureAction(Errors.networkException());
      } else {
        yield MainReposPageLoadFailureAction(Exception('请求更多数据失败'));
      }
    }
  }
}
