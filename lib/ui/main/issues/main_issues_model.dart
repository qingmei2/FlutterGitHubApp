import 'package:flutter/material.dart';
import 'package:flutter_rhine/common/model/issue.dart';
import 'package:flutter_rhine/repository/dao_result.dart';
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
  String _state = IssuesRepository.STATE_OPEN;

  // 加载框是否可见
  bool _isLoading;

  Future<DataResult> fetchIssues() async {
    final DataResult<List<Issue>> res = await IssuesRepository.fetchIssues(
        page: _pagedIndex + 1, sort: _sort, state: _state);

    print('fetchIssues result:' + res.data.toString());

    if (res.result) {
      _issues.addAll(res.data);
    } else {}

    return res;
  }
}
