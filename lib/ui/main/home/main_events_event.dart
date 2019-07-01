import 'package:meta/meta.dart';

abstract class MainEventsEvent {}

/// 第一次加载数据
class MainEventsInitialEvent extends MainEventsEvent {
  final String username;

  MainEventsInitialEvent({
    @required this.username,
  }) : assert(username != null);
}

/// 加载更多
class MainEventLoadNextPageEvent extends MainEventsEvent {
  final String username;

  MainEventLoadNextPageEvent({
    @required this.username,
  }) : assert(username != null);
}
