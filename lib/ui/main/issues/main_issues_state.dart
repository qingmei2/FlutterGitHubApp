import 'package:flutter_rhine/common/common.dart';
import 'package:meta/meta.dart';

class MainIssuesState {

}

abstract class MainIssuesStates {
  final bool isLoading;
  final int currentPage;
  final List<Issue> issues;
  final String listSort;
  final String listState;

  MainIssuesStates({
    @required this.currentPage,
    this.issues,
    this.isLoading = false,
    this.listSort = IssuesRepository.SORT_UPDATED,
    this.listState = IssuesRepository.STATE_OPEN,
  }) : assert(currentPage != null);
}

/// 加载中
class MainIssuesFirstLoading extends MainIssuesStates {
  MainIssuesFirstLoading() : super(isLoading: true, currentPage: 0, issues: []);
}

/// 空列表状态
class MainIssuesEmptyState extends MainIssuesStates {
  MainIssuesEmptyState() : super(currentPage: 0, isLoading: false);
}

/// 加载分页数据成功
class MainIssuesPageLoadSuccess extends MainIssuesStates {
  MainIssuesPageLoadSuccess({
    @required List<Issue> issues,
    @required int currentPage,
  }) : super(currentPage: currentPage, issues: issues, isLoading: false);
}

/// 加载分页数据失败
class MainIssuesPageLoadFailure extends MainIssuesStates {
  final String errorMessage;

  MainIssuesPageLoadFailure({
    @required int currentPage,
    @required this.errorMessage,
    List<Issue> issues,
  }) : super(currentPage: currentPage, issues: issues, isLoading: false);
}
