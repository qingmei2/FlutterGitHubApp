import 'package:flutter_rhine/common/common.dart';
import 'package:meta/meta.dart';

class MainReposState {}

abstract class MainReposStates {
  final bool isLoading;
  final int currentPage;
  final List<Repo> repos;
  final String sortType;

  MainReposStates({
    @required this.currentPage,
    this.repos,
    this.isLoading = false,
    this.sortType = UserRepoRepository.SORT_UPDATED,
  }) : assert(currentPage != null);
}

/// 加载中
class MainReposFirstLoading extends MainReposStates {
  MainReposFirstLoading() : super(isLoading: true, currentPage: 0, repos: []);
}

/// 空列表状态
class MainReposEmptyState extends MainReposStates {
  MainReposEmptyState() : super(currentPage: 0, isLoading: false);
}

/// 加载分页数据成功
class MainReposPageLoadSuccess extends MainReposStates {
  MainReposPageLoadSuccess({
    @required List<Repo> repos,
    @required int currentPage,
  }) : super(currentPage: currentPage, repos: repos, isLoading: false);
}

/// 加载分页数据失败
class MainReposPageLoadFailure extends MainReposStates {
  final String errorMessage;

  MainReposPageLoadFailure({
    @required int currentPage,
    @required this.errorMessage,
    List<Repo> repos,
  }) : super(currentPage: currentPage, repos: repos, isLoading: false);
}
