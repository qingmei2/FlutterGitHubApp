import 'package:flutter_rhine/common/common.dart';
import 'package:meta/meta.dart';

abstract class MainReposState {
  final bool isLoading;
  final int currentPage;
  final List<Repo> repos;
  final String sortType;

  MainReposState({
    @required this.currentPage,
    this.repos,
    this.isLoading = false,
    this.sortType = UserRepoRepository.SORT_UPDATED,
  }) : assert(currentPage != null);
}

/// 加载中
class MainReposFirstLoading extends MainReposState {
  MainReposFirstLoading() : super(isLoading: true, currentPage: 0, repos: []);
}

/// 空列表状态
class MainReposEmptyState extends MainReposState {
  MainReposEmptyState() : super(currentPage: 0, isLoading: false);
}

/// 加载分页数据成功
class MainReposPageLoadSuccess extends MainReposState {
  MainReposPageLoadSuccess({
    @required List<Repo> repos,
    @required int currentPage,
  }) : super(currentPage: currentPage, repos: repos, isLoading: false);
}

/// 加载分页数据失败
class MainReposPageLoadFailure extends MainReposState {
  final String errorMessage;

  MainReposPageLoadFailure({
    @required int currentPage,
    @required this.errorMessage,
    List<Repo> repos,
  }) : super(currentPage: currentPage, repos: repos, isLoading: false);
}
