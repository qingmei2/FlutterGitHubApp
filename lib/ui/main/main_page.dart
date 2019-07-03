import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rhine/common/constants/assets.dart';
import 'package:flutter_rhine/common/constants/colors.dart';
import 'package:flutter_rhine/repository/repository.dart';
import 'package:flutter_rhine/ui/main/home/main_events_page.dart';
import 'package:flutter_rhine/ui/main/issues/main_issues_page.dart';
import 'package:flutter_rhine/ui/main/mine/main_profile_page.dart';
import 'package:flutter_rhine/ui/main/repos/main_repo_page.dart';

import 'main.dart';

class MainPage extends StatefulWidget {
  final UserRepository userRepository;

  MainPage({Key key, @required this.userRepository}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MainPageState(userRepository: userRepository);
  }
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final UserRepository userRepository;

  final _pageController = PageController();
  final MainPageBloc mainBloc = MainPageBloc();

  _MainPageState({@required this.userRepository});

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
      Image.asset(mainNavIssueNormal, width: 24.0, height: 24.0),
      Image.asset(mainNavIssuePressed, width: 24.0, height: 24.0),
    ],
    [
      Image.asset(mainNavProfileNormal, width: 24.0, height: 24.0),
      Image.asset(mainNavProfilePressed, width: 24.0, height: 24.0),
    ]
  ];

  final List<String> _bottomTabTitles = ['home', 'repos', 'issues', 'me'];

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (_) => mainBloc,
      child: WillPopScope(
        onWillPop: () {
          return _dialogExitApp(context);
        },
        child: BlocListener<MainPageEvent, MainPageState>(
          bloc: mainBloc,
          listener: (_, state) {
            final int currentPosition = _pageController.page.toInt();
            final int newPosition = state.currentPageIndex;
            if (currentPosition != newPosition)
              _pageController.jumpToPage(newPosition);
          },
          child: BlocBuilder<MainPageEvent, MainPageState>(
            bloc: mainBloc,
            builder: (_, state) => Scaffold(
                  body: PageView(
                    children: <Widget>[
                      MainEventsPage(userRepository: userRepository),
                      MainReposPage(userRepository: userRepository),
                      MainIssuesPage(),
                      MainProfilePage(userRepository: userRepository)
                    ],
                    controller: _pageController,
                    onPageChanged: (index) {
                      mainBloc.dispatch(MainSwipeViewPagerEvent(index));
                    },
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    backgroundColor: colorPrimary,
                    items: <BottomNavigationBarItem>[
                      _bottomNavigationBarItem(
                          state, MainPageState.TAB_INDEX_EVENTS),
                      _bottomNavigationBarItem(
                          state, MainPageState.TAB_INDEX_REPOS),
                      _bottomNavigationBarItem(
                          state, MainPageState.TAB_INDEX_ISSUES),
                      _bottomNavigationBarItem(
                          state, MainPageState.TAB_INDEX_PROFILE),
                    ],
                    currentIndex: state.currentPageIndex,
                    iconSize: 24.0,
                    type: BottomNavigationBarType.fixed,
                    onTap: (newIndex) {
                      mainBloc.dispatch(MainChoiceBottomTabEvent(newIndex));
                    },
                  ),
                ),
          ),
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

  BottomNavigationBarItem _bottomNavigationBarItem(
      MainPageState state, int tabIndex) {
    return BottomNavigationBarItem(
      icon: _getTabIcon(state.currentPageIndex, tabIndex),
      title: _getTabTitle(state.currentPageIndex, tabIndex),
    );
  }

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
