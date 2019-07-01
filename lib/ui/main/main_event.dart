abstract class MainPageEvent {}

class MainChoiceBottomTabEvent extends MainPageEvent {
  final int newTabIndex;

  MainChoiceBottomTabEvent(this.newTabIndex);
}

class MainSwipeViewPagerEvent extends MainPageEvent {
  final int currentItem;

  MainSwipeViewPagerEvent(this.currentItem);
}
