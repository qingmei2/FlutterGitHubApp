import 'package:flutter_rhine/common/common.dart';
import 'package:meta/meta.dart';

abstract class MainEventsState {
  final bool isLoading;
  final int currentPage;
  final List<Event> events;

  MainEventsState({
    @required this.currentPage,
    this.events,
    this.isLoading = false,
  }) : assert(currentPage != null);

  static MainEventsState initial() => MainEventsEmptyState();
}

/// 加载中
class MainEventsFirstLoading extends MainEventsState {
  MainEventsFirstLoading() : super(isLoading: true, currentPage: 0, events: []);
}

/// 空列表状态
class MainEventsEmptyState extends MainEventsState {
  MainEventsEmptyState() : super(currentPage: 0, isLoading: false);
}

/// 加载分页数据成功
class MainEventsPageLoadSuccess extends MainEventsState {
  MainEventsPageLoadSuccess({
    @required List<Event> events,
    @required int currentPage,
  }) : super(currentPage: currentPage, events: events, isLoading: false);
}

/// 加载分页数据失败
class MainEventPageLoadFailure extends MainEventsState {
  final String errorMessage;

  MainEventPageLoadFailure({
    @required int currentPage,
    @required this.errorMessage,
    List<Event> events,
  }) : super(currentPage: currentPage, events: events, isLoading: false);
}
