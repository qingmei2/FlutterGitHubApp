import 'package:flutter_rhine/common/common.dart';

import '../main.dart';

class MainEventsEpic implements EpicClass<AppState> {
  @override
  Stream call(Stream actions, EpicStore<AppState> store) {
    return Observable.merge([
      Observable(actions)
          .ofType(TypeToken<MainEventsInitialAction>())
          .flatMap((event) => _pagingRequestStream(1, [], event.username)),
      Observable(actions)
          .ofType(TypeToken<MainEventLoadNextPageAction>())
          .flatMap((event) =>
              _pagingRequestStream(event.currentPage + 1, [], event.username)),
    ]);
  }

  /// 分页网络请求
  /// [newPageIndex] 新的分页索引
  /// [previousList] 之前的列表数据
  /// [username]     用户名
  Stream _pagingRequestStream(
      int newPageIndex, List<Event> previousList, String username) async* {
    final DataResult<List<Event>> result =
        await UserEventRepository.fetchEvents(username, newPageIndex);

    if (result.result) {
      if (result.data.length > 0) {
        final List<Event> eventList = result.data;
        previousList.addAll(eventList);

        yield MainEventsPageLoadSuccessAction(previousList, newPageIndex);
      } else {
        if (newPageIndex == 1) {
          yield MainEventPageLoadFailureAction(Errors.emptyListException());
        } else {
          yield MainEventPageLoadFailureAction(Errors.noMoreDataException());
        }
      }
    } else {
      if (newPageIndex == 1) {
        yield MainEventPageLoadFailureAction(Exception('初始化网络请求失败'));
      } else {
        yield MainEventPageLoadFailureAction(Exception('请求更多数据失败'));
      }
    }
  }
}
