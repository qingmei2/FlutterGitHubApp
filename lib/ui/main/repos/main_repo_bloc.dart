import 'package:bloc/bloc.dart';
import 'package:flutter_rhine/common/common.dart';

import 'main_repo.dart';

class MainReposBloc extends Bloc<MainReposEvent, MainReposState> {
  @override
  MainReposState get initialState => MainReposEmptyState();

  @override
  Stream<MainReposState> mapEventToState(MainReposEvent event) async* {
    final MainReposState nowState = currentState;

    if (event is MainReposInitialEvent) {
      yield MainReposFirstLoading();
      yield* _pagingRequestStream(1, [], event.username, event.sortType);
    }

    if (event is MainReposChangeFilterEvent) {
      yield MainReposFirstLoading();
      yield* _pagingRequestStream(1, [], event.username, event.sortType);
    }

    if (event is MainReposLoadNextPageEvent) {
      final int newPage = nowState.currentPage + 1;
      final List<Repo> oldList = nowState.repos;
      final String sortType = nowState.sortType;
      yield* _pagingRequestStream(newPage, oldList, event.username, sortType);
    }
  }

  /// 分页网络请求
  /// [newPageIndex] 新的分页索引
  /// [previousList] 之前的列表数据
  /// [username]     用户名
  /// [sort]         排序规则，应使用[UserRepoRepository.SORT_UPDATED]、[UserRepoRepository.SORT_CREATED]、[UserRepoRepository.SORT_LETTER]
  Stream<MainReposState> _pagingRequestStream(
    int newPageIndex,
    List<Repo> previousList,
    String username,
    String sort,
  ) async* {
    final DataResult<List<Repo>> result = await UserRepoRepository.fetchRepos(
      username: username,
      sort: sort,
      pageIndex: newPageIndex,
    );

    if (result.result) {
      if (result.data.length > 0) {
        final List<Repo> eventList = result.data;
        previousList.addAll(eventList);

        yield MainReposPageLoadSuccess(
          repos: previousList,
          currentPage: newPageIndex,
        );
      } else {
        if (newPageIndex == 1) {
          yield MainReposEmptyState();
        } else {
          yield MainReposPageLoadFailure(
            currentPage: newPageIndex,
            repos: previousList,
            errorMessage: '没有更多了',
          );
        }
      }
    } else {
      if (newPageIndex == 1) {
        yield MainReposPageLoadFailure(
            currentPage: 1, errorMessage: '初始化网络请求失败');
      } else {
        yield MainReposPageLoadFailure(
          currentPage: newPageIndex,
          repos: previousList,
          errorMessage: '请求更多数据失败',
        );
      }
    }
  }
}
