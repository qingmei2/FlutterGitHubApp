import 'package:flutter/material.dart';
import 'package:flutter_rhine/common/constants/api.dart';
import 'package:flutter_rhine/common/constants/config.dart';
import 'package:flutter_rhine/common/model/repo.dart';
import 'package:flutter_rhine/common/service/service_manager.dart';
import 'package:flutter_rhine/dao/dao_result.dart';

class MainRepoModel extends ChangeNotifier {
  // 事件列表
  List<Repo> _repoPagedList = [];

  // 当前页数
  int _pagedIndex = 0;

  // 加载框是否可见
  bool _isLoading;

  // 排序条件，默认按照更新时间排序
  String _sort = 'updated';

  List<Repo> get repoPagedList => _repoPagedList;

  bool get isLoading => _isLoading;

  void updateProgressVisible(final bool visible) {
    if (_isLoading != visible) {
      _isLoading = visible;
      notifyListeners();
    }
  }

  void _onPagedLoadSuccess(final List<Repo> newRepos) {
    _repoPagedList.addAll(newRepos);
    _pagedIndex++;

    notifyListeners();
  }

  void _onSortParamChanged(final String sort) {
    _sort = sort;

    _clearList();
  }

  void _clearList() {
    _repoPagedList.clear();
    _pagedIndex = 0;

    notifyListeners();
  }

  /// 更新列表数据
  /// [username] 用户名
  /// [sort] 排序方式，当该参数发生了改变，clear列表并刷新ui
  Future<DataResult> fetchRepos(final String username,
      {final String sort}) async {
    if (_isLoading == true) {
      return DataResult.failure();
    }

    if (sort != null && sort != _sort) {
      _onSortParamChanged(sort);
    }

    updateProgressVisible(true);

    var res = await serviceManager.netFetch(
        Api.userRepos(username) +
            Api.getPageParams('?', _pagedIndex + 1) +
            '&sort=$_sort',
        null,
        null,
        null);

    var resultData;
    if (res != null && res.result) {
      final List<Repo> repos = getRepoList(res.data);
      _onPagedLoadSuccess(repos);

      resultData = DataResult.success(repos);

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
