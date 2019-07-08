import 'package:flutter_rhine/common/common.dart';
import 'package:meta/meta.dart';

abstract class MainEventsAction {}

/// 第一次加载数据
class MainEventsInitialAction extends MainEventsAction {
  final String username;

  MainEventsInitialAction({
    @required this.username,
  }) : assert(username != null);
}

/// 加载更多
class MainEventLoadNextPageAction extends MainEventsAction {
  final String username;
  final int currentPage;

  MainEventLoadNextPageAction({
    @required this.username,
    @required this.currentPage,
  })  : assert(username != null),
        assert(currentPage != null);
}

/// 加载中
class MainEventsFirstLoadingAction extends MainEventsAction {}

/// 加载分页数据成功
class MainEventsPageLoadSuccessAction extends MainEventsAction {
  final List<Event> events;
  final int currentPage;

  MainEventsPageLoadSuccessAction(
    this.events,
    this.currentPage,
  );
}

/// 加载分页数据失败
class MainEventPageLoadFailureAction extends MainEventsAction {
  final Exception exception;

  MainEventPageLoadFailureAction(
    this.exception,
  );
}
