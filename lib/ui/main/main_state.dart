abstract class MainPageState {
  static const int TAB_INDEX_EVENTS = 0;
  static const int TAB_INDEX_REPOS = 1;
  static const int TAB_INDEX_ISSUES = 2;
  static const int TAB_INDEX_PROFILE = 3;

  final int currentPageIndex;

  MainPageState(this.currentPageIndex);

  static MainNormalState initial() {
    return MainNormalState(TAB_INDEX_EVENTS);
  }
}

class MainNormalState extends MainPageState {
  MainNormalState(int newIndex) : super(newIndex);
}
