import 'package:flutter/material.dart';

class MainPageModel with ChangeNotifier {
  static const int TAB_INDEX_EVENTS = 0;
  static const int TAB_INDEX_REPOS = 1;
  static const int TAB_INDEX_PROFILE = 2;

  /// 当前选中页面的状态
  int _currentPageIndex = 0;

  int get currentPageIndex => _currentPageIndex;

  /// 更新选中的tab
  void onTabPageChanged(int newIndex) {
    _verifyIndexLegal(newIndex);
    if (_currentPageIndex != newIndex) {
      _currentPageIndex = newIndex;
      notifyListeners();
    }
  }

  /// 校验index是否合法
  void _verifyIndexLegal(int index) {
    var legals = [TAB_INDEX_EVENTS, TAB_INDEX_REPOS, TAB_INDEX_PROFILE];
    if (!legals.contains(index))
      throw Exception('newIndex error, should be $legals, but is $index.');
  }
}
