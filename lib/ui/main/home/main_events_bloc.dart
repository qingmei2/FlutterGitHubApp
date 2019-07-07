import 'package:bloc/bloc.dart';
import 'package:flutter_rhine/common/common.dart';

import 'main_events.dart';

class MainEventsBloc extends Bloc<MainEventsEvent, MainEventsStates> {
  @override
  MainEventsStates get initialState => MainEventsEmptyState();

  @override
  Stream<MainEventsStates> mapEventToState(MainEventsEvent event) async* {
    final MainEventsStates nowState = currentState;

    if (event is MainEventsInitialEvent) {
      yield MainEventsFirstLoading();
      yield* _pagingRequestStream(1, [], event.username);
    }

    if (event is MainEventLoadNextPageEvent) {
      final int newPage = nowState.currentPage + 1;
      final List<Event> oldList = nowState.events;
      yield* _pagingRequestStream(newPage, oldList, event.username);
    }
  }

  /// 分页网络请求
  /// [newPageIndex] 新的分页索引
  /// [previousList] 之前的列表数据
  /// [username]     用户名
  Stream<MainEventsStates> _pagingRequestStream(
      int newPageIndex, List<Event> previousList, String username) async* {
    final DataResult<List<Event>> result =
        await UserEventRepository.fetchEvents(username, newPageIndex);

    if (result.result) {
      if (result.data.length > 0) {
        final List<Event> eventList = result.data;
        previousList.addAll(eventList);

        yield MainEventsPageLoadSuccess(
            events: previousList, currentPage: newPageIndex);
      } else {
        if (newPageIndex == 1) {
          yield MainEventsEmptyState();
        } else {
          yield MainEventPageLoadFailure(
            currentPage: newPageIndex,
            events: previousList,
            errorMessage: '没有更多了',
          );
        }
      }
    } else {
      if (newPageIndex == 1) {
        yield MainEventPageLoadFailure(
            currentPage: 1, errorMessage: '初始化网络请求失败');
      } else {
        yield MainEventPageLoadFailure(
          currentPage: newPageIndex,
          events: previousList,
          errorMessage: '请求更多数据失败',
        );
      }
    }
  }
}
