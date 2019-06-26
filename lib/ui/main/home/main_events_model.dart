import 'package:flutter/material.dart';
import 'package:flutter_rhine/common/constants/api.dart';
import 'package:flutter_rhine/common/constants/config.dart';
import 'package:flutter_rhine/common/model/event.dart';
import 'package:flutter_rhine/common/service/service_manager.dart';
import 'package:flutter_rhine/repository/dao_result.dart';

class MainEventsModel extends ChangeNotifier {
  // 事件列表
  List<Event> _eventPagedList = [];

  // 当前页数
  int _pagedIndex = 0;

  // 加载框是否可见
  bool _isLoading;

  List<Event> get eventPagedList => _eventPagedList;

  bool get isLoading => _isLoading;

  void updateProgressVisible(final bool visible) {
    if (_isLoading != visible) {
      _isLoading = visible;
      notifyListeners();
    }
  }

  void _onPagedLoadSuccess(final List<Event> newEvents) {
    _eventPagedList.addAll(newEvents);
    _pagedIndex++;

    notifyListeners();
  }

  /// 更新列表数据
  /// [username] 用户名
  Future<DataResult> fetchEvents(final String username) async {
    if (_isLoading == true) {
      return DataResult.failure();
    }

    updateProgressVisible(true);

    var res = await serviceManager.netFetch(
        Api.userEvents(username) + Api.getPageParams('?', _pagedIndex + 1),
        null,
        null,
        null);

    var resultData;
    if (res != null && res.result) {
      final List<Event> events = getEventList(res.data);
      _onPagedLoadSuccess(events);

      resultData = DataResult.success(events);

      if (Config.DEBUG) {
        print("resultData events result " + resultData.result.toString());
        print(resultData.data);
        print(res.data.toString());
      }
    }

    updateProgressVisible(false);

    return resultData;
  }
}
