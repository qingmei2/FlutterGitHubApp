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

  /// 更新列表数据
  /// [username] 用户名
  Future<DataResult> fetchRepos(final String username) async {
    if (_isLoading == true) {
      return DataResult.failure();
    }

    updateProgressVisible(true);

    var res = await serviceManager.netFetch(
        Api.userRepos(username) + Api.getPageParams('?', _pagedIndex + 1),
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
