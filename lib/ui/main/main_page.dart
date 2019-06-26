import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rhine/common/constants/assets.dart';
import 'package:flutter_rhine/common/constants/colors.dart';
import 'package:flutter_rhine/ui/main/home/main_events_page.dart';
import 'package:flutter_rhine/ui/main/main_page_model.dart';
import 'package:flutter_rhine/ui/main/mine/main_profile_page.dart';
import 'package:flutter_rhine/ui/main/repos/main_repo_page.dart';
import 'package:provider/provider.dart';
import 'package:android_intent/android_intent.dart';

class MainPage extends StatefulWidget {
  static final String path = 'main_page';

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final List<List<Image>> _bottomTabIcons = [
    [
      Image.asset(mainNavEventsNormal, width: 24.0, height: 24.0),
      Image.asset(mainNavEventsPressed, width: 24.0, height: 24.0),
    ],
    [
      Image.asset(mainNavReposNormal, width: 24.0, height: 24.0),
      Image.asset(mainNavReposPressed, width: 24.0, height: 24.0),
    ],
    [
      Image.asset(mainNavProfileNormal, width: 24.0, height: 24.0),
      Image.asset(mainNavProfilePressed, width: 24.0, height: 24.0),
    ]
  ];

  final List<String> _bottomTabTitles = ['home', 'repos', 'me'];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<MainPageModel>(context).pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MainPageModel _pageModel = Provider.of<MainPageModel>(context);
    return WillPopScope(
      onWillPop: () {
        return _dialogExitApp(context);
      },
      child: Scaffold(
        body: PageView(
          children: <Widget>[
            MainEventsPage(),
            MainReposPage(),
            MainProfilePage()
          ],
          controller: _pageModel.pageController,
          onPageChanged: (index) {
            _pageModel.onTabPageChanged(index);
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: colorPrimary,
          items: <BottomNavigationBarItem>[
            _bottomNavigationBarItem(
                _pageModel, MainPageModel.TAB_INDEX_EVENTS),
            _bottomNavigationBarItem(_pageModel, MainPageModel.TAB_INDEX_REPOS),
            _bottomNavigationBarItem(
                _pageModel, MainPageModel.TAB_INDEX_PROFILE),
          ],
          currentIndex: _pageModel.currentPageIndex,
          iconSize: 24.0,
          type: BottomNavigationBarType.fixed,
          onTap: (newIndex) {
            _pageModel.onTabPageChanged(newIndex);
          },
        ),
      ),
    );
  }

  /// 不退出
  Future<bool> _dialogExitApp(BuildContext context) async {
    ///如果是 android 回到桌面
    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: "android.intent.category.HOME",
      );
      await intent.launch();
    }

    return Future.value(false);
  }

  BottomNavigationBarItem _bottomNavigationBarItem(MainPageModel provide,
      int tabIndex) =>
      BottomNavigationBarItem(
        icon: _getTabIcon(provide.currentPageIndex, tabIndex),
        title: _getTabTitle(provide.currentPageIndex, tabIndex),
      );

  Image _getTabIcon(int currentPageIndex, int tabIndex) =>
      (currentPageIndex == tabIndex)
          ? _bottomTabIcons[tabIndex][1]
          : _bottomTabIcons[tabIndex][0];

  Text _getTabTitle(int currentPageIndex, int tabIndex) {
    final String title = _bottomTabTitles[tabIndex];
    final Color textColor =
    (currentPageIndex == tabIndex) ? Colors.white : colorSecondaryTextGray;
    return Text(title, style: TextStyle(fontSize: 14.0, color: textColor));
  }
}
