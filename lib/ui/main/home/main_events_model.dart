import 'package:flutter/material.dart';
import 'package:flutter_rhine/common/constants/api.dart';
import 'package:flutter_rhine/common/constants/config.dart';
import 'package:flutter_rhine/common/model/event.dart';
import 'package:flutter_rhine/common/service/service_manager.dart';
import 'package:flutter_rhine/dao/dao_result.dart';

class MainEventsModel extends ChangeNotifier {
  // 事件列表
  List<Event> _eventPagedList = [];

  // 当前页数
  int _pagedIndex = 1;

  // 加载框是否可见
  bool _isLoading;

  List<Event> get eventPagedList => _eventPagedList;

  int get pagedIndex => _pagedIndex;

  bool get isLoading => _isLoading;

  void updateProgressVisible(final bool visible) {
    if (_isLoading != visible) {
      _isLoading = visible;
      notifyListeners();
    }
  }

  /// 更新列表数据
  /// [username] 用户名
  Future<DataResult> fetchEvents(final String username) async {
    if (_isLoading) {
      return DataResult.failure();
    }
    _isLoading = true;

    updateProgressVisible(true);

    var res = serviceManager.netFetch(Api.userEvents(username),
        Api.getPageParams('?', _pagedIndex), null, null);
    var resultData;
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("api request result " + res.result.toString());
      }

      final List<Event> events = getEventList(res.result);
      resultData = DataResult.success(events);
      if (Config.DEBUG) {
        print("user result " + resultData.result.toString());
        print(resultData.data);
        print(res.data.toString());
      }
    }

    updateProgressVisible(false);

    return resultData;
  }
}
