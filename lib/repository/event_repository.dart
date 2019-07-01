import 'package:flutter_rhine/common/common.dart';

class UserEventRepository {
  UserEventRepository._();

  /// 拉取用户Event分页数据
  /// [username] 用户名
  /// [pageIndex] 分页索引
  static Future<DataResult<List<Event>>> fetchEvents(
      final String username, final int pageIndex) async {
    var res = await serviceManager.netFetch(
        Api.userEvents(username) + Api.getPageParams('?', pageIndex),
        null,
        null,
        null);

    var resultData;
    if (res != null && res.result) {
      final List<Event> events = getEventList(res.data);

      resultData = DataResult.success(events);

      if (Config.DEBUG) {
        print("resultData events result " + resultData.result.toString());
        print(resultData.data);
        print(res.data.toString());
      }
    } else {
      resultData = DataResult.failure();
    }

    return resultData;
  }
}
