import 'mine/main_profile.dart';

abstract class MainPageAction {}

class MainSwipeViewPagerAction extends MainPageAction {
  final int currentItem;

  MainSwipeViewPagerAction(this.currentItem);
}

class MainProfileUpdateAction extends MainPageAction {
  final MainProfileState state;

  MainProfileUpdateAction(this.state);
}
