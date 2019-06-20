import 'package:flutter/material.dart';
import 'package:flutter_rhine/constants/assets.dart';
import 'package:flutter_rhine/constants/colors.dart';
import 'package:flutter_rhine/pages/main/main_profile_page.dart';
import 'package:flutter_rhine/pages/main/main_repo_page.dart';
import 'package:flutter_rhine/provider/main/main_provider.dart';
import 'package:provide/provide.dart';

import 'main_events_page.dart';

class MainPage extends StatelessWidget {
  static final String path = 'main_page';

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

  final List<Widget> _pagedList = [
    MainEventsPage(),
    MainReposPage(),
    MainProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Provide<MainPageProvider>(builder: (context, child, val) {
      final MainPageProvider provide = Provide.value<MainPageProvider>(context);
      return Scaffold(
        body: _pagedList[provide.currentPageIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: colorPrimary,
          items: <BottomNavigationBarItem>[
            _bottomNavigationBarItem(provide, MainPageProvider.TAB_INDEX_EVENTS),
            _bottomNavigationBarItem(provide, MainPageProvider.TAB_INDEX_REPOS),
            _bottomNavigationBarItem(
                provide, MainPageProvider.TAB_INDEX_PROFILE),
          ],
          currentIndex: provide.currentPageIndex,
          iconSize: 24.0,
          type: BottomNavigationBarType.fixed,
          onTap: (newIndex) => provide.onTabPageChanged(newIndex),
        ),
      );
    });
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
          MainPageProvider provide, int tabIndex) =>
      BottomNavigationBarItem(
        icon: _getTabIcon(provide.currentPageIndex, tabIndex),
        title: _getTabTitle(provide.currentPageIndex, tabIndex),
      );

  Image _getTabIcon(int currentPageIndex, int tabIndex) =>
      (currentPageIndex == tabIndex)
          ? _bottomTabIcons[tabIndex][0]
          : _bottomTabIcons[tabIndex][1];

  Text _getTabTitle(int currentPageIndex, int tabIndex) {
    final String title = _bottomTabTitles[tabIndex];
    final Color textColor =
        (currentPageIndex == tabIndex) ? Colors.white : colorSecondaryTextGray;
    return Text(title, style: TextStyle(fontSize: 14.0, color: textColor));
  }
}
