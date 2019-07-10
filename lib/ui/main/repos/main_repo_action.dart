import 'package:flutter_rhine/common/common.dart';
import 'package:meta/meta.dart';

abstract class MainReposAction {}

/// 第一次加载数据，默认按照更新时间排序
class MainReposInitialAction extends MainReposAction {
  final String username;
  final String sortType = UserRepoRepository.SORT_UPDATED;

  MainReposInitialAction({
    @required this.username,
  }) : assert(username != null);
}

/// sort排序规则修改
class MainReposChangeFilterAction extends MainReposAction {
  final String username;
  final String sortType;

  MainReposChangeFilterAction({
    @required this.username,
    @required this.sortType,
  }) : assert(sortType != null && username != null);
}

/// 加载更多
class MainReposLoadNextPageAction extends MainReposAction {
  final String username;
  final List<Repo> preList;
  final String sortType;
  final int currentPageIndex;

  MainReposLoadNextPageAction({
    @required this.username,
    @required this.currentPageIndex,
    @required this.preList,
    @required this.sortType,
  }) : assert(username != null);
}

/// 加载中
class MainReposLoadingAction extends MainReposAction {}

/// 空列表状态
class MainReposEmptyAction extends MainReposAction {}

/// 加载分页数据成功
class MainReposPageLoadSuccessAction extends MainReposAction {
  final List<Repo> repos;
  final int currentPage;
  final String sortType;

  MainReposPageLoadSuccessAction({
    this.repos,
    this.currentPage,
    this.sortType,
  });
}

/// 加载分页数据失败
class MainReposPageLoadFailureAction extends MainReposAction {
  final Exception exception;

  MainReposPageLoadFailureAction(this.exception);
}
