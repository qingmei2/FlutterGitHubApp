import 'package:flutter_rhine/common/common.dart';
import 'package:meta/meta.dart';

class MainEventsState {

}

abstract class MainEventsStates {
  final bool isLoading;
  final int currentPage;
  final List<Event> events;

  MainEventsStates({
    @required this.currentPage,
    this.events,
    this.isLoading = false,
  }) : assert(currentPage != null);

  static MainEventsStates initial() => MainEventsEmptyState();
}

/// 加载中
class MainEventsFirstLoading extends MainEventsStates {
  MainEventsFirstLoading() : super(isLoading: true, currentPage: 0, events: []);
}

/// 空列表状态
class MainEventsEmptyState extends MainEventsStates {
  MainEventsEmptyState() : super(currentPage: 0, isLoading: false);
}

/// 加载分页数据成功
class MainEventsPageLoadSuccess extends MainEventsStates {
  MainEventsPageLoadSuccess({
    @required List<Event> events,
    @required int currentPage,
  }) : super(currentPage: currentPage, events: events, isLoading: false);
}

/// 加载分页数据失败
class MainEventPageLoadFailure extends MainEventsStates {
  final String errorMessage;

  MainEventPageLoadFailure({
    @required int currentPage,
    @required this.errorMessage,
    List<Event> events,
  }) : super(currentPage: currentPage, events: events, isLoading: false);
}
