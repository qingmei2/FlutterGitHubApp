abstract class MainIssuesEvent {}

/// 第一次加载数据
class MainIssuesInitialEvent extends MainIssuesEvent {
  MainIssuesInitialEvent();
}

/// 加载更多
class MainIssuesLoadNextPageEvent extends MainIssuesEvent {
  MainIssuesLoadNextPageEvent();
}
