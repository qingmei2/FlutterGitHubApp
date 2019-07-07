abstract class MainPageAction {}

class MainSwipeViewPagerAction extends MainPageAction {
  final int currentItem;

  MainSwipeViewPagerAction(this.currentItem);
}
