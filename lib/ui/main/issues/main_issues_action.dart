import 'package:flutter_rhine/common/common.dart';

abstract class MainIssuesAction {}

/// 第一次加载数据
class MainIssuesInitialAction extends MainIssuesAction {

  MainIssuesInitialAction();
}

/// 加载更多
class MainIssuesLoadNextPageAction extends MainIssuesAction {
  final int currentPage;
  final List<Issue> previousList;

  MainIssuesLoadNextPageAction({
    @required this.currentPage,
    this.previousList = const [],
  })  : assert(currentPage != null);
}

/// 加载中
class MainIssuesFirstLoadingAction extends MainIssuesAction {
  MainIssuesFirstLoadingAction();
}

/// 空列表状态
class MainIssuesEmptyAction extends MainIssuesAction {
  MainIssuesEmptyAction();
}

/// 加载分页数据成功
class MainIssuesPageLoadSuccess extends MainIssuesAction {
  final List<Issue> issues;
  final int currentPage;

  MainIssuesPageLoadSuccess({
    this.issues,
    this.currentPage,
  });
}

/// 加载分页数据失败
class MainIssuesPageLoadFailure extends MainIssuesAction {
  final Exception exception;

  MainIssuesPageLoadFailure(this.exception);
}
