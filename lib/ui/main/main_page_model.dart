import 'package:flutter/material.dart';

class MainPageModel with ChangeNotifier {
  static const int TAB_INDEX_EVENTS = 0;
  static const int TAB_INDEX_REPOS = 1;
  static const int TAB_INDEX_ISSUES = 2;
  static const int TAB_INDEX_PROFILE = 3;

  /// 当前选中页面的状态
  int _currentPageIndex = 0;

  int get currentPageIndex => _currentPageIndex;

  // 页面切换Controller
  final PageController pageController = PageController();

  /// 更新选中的tab
  /// [newIndex] 最新的pageIndex
  void onTabPageChanged(int newIndex) {
    _verifyIndexLegal(newIndex);
    if (_currentPageIndex != newIndex) {
      _currentPageIndex = newIndex;
      pageController.jumpToPage(newIndex);
      notifyListeners();
    }
  }

  /// 校验index是否合法
  void _verifyIndexLegal(int index) {
    var legals = [
      TAB_INDEX_EVENTS,
      TAB_INDEX_REPOS,
      TAB_INDEX_ISSUES,
      TAB_INDEX_PROFILE
    ];
    if (!legals.contains(index))
      throw Exception('newIndex error, should be $legals, but is $index.');
  }
}
