import 'package:flutter/material.dart';
import 'package:flutter_rhine/common/model/issue.dart';
import 'package:flutter_rhine/repository/others/dao_result.dart';
import 'package:flutter_rhine/repository/issues_repository.dart';

class MainIssuesModel extends ChangeNotifier {
  // issues列表
  List<Issue> _issues = [];

  List<Issue> get issues => _issues;

  // 当前页数
  int _pagedIndex = 0;

  // 排序规则，默认按照更新时间排序
  String _sort = IssuesRepository.SORT_UPDATED;

  // 筛选状态，默认只显示打开的issue
  String _state = IssuesRepository.STATE_ALL;

  // 加载框是否可见
  bool _isLoading;

  bool get isLoading => _isLoading;

  void updateProgressVisible(final bool visible) {
    if (_isLoading != visible) {
      _isLoading = visible;
      notifyListeners();
    }
  }

  void _onPagedLoadSuccess(final List<Issue> newIssues) {
    _issues.addAll(newIssues);
    _pagedIndex++;

    notifyListeners();
  }

  Future<DataResult> fetchIssues() async {
    updateProgressVisible(true);

    final DataResult<List<Issue>> res = await IssuesRepository.fetchIssues(
        page: _pagedIndex + 1, sort: _sort, state: _state);

    updateProgressVisible(false);

    print('fetchIssues result:' + res.data.toString());

    if (res.result) {
      _onPagedLoadSuccess(res.data);
    } else {
      print('用户Issues加载失败...');
    }

    return res;
  }
}
