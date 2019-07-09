import 'package:flutter_rhine/common/common.dart';

import 'main.dart';

@immutable
class MainPageState {
  static const int TAB_INDEX_EVENTS = 0;
  static const int TAB_INDEX_REPOS = 1;
  static const int TAB_INDEX_ISSUES = 2;
  static const int TAB_INDEX_PROFILE = 3;

  final int currentPageIndex;
  final MainEventsState eventState;
  final MainReposState repoState;
  final MainIssuesState issueState;
  final MainProfileState profileState;

  MainPageState({
    this.currentPageIndex,
    this.eventState,
    this.repoState,
    this.issueState,
    this.profileState,
  });

  factory MainPageState.initial() {
    return MainPageState(
      currentPageIndex: 0,
      eventState: MainEventsState(),
      issueState: MainIssuesState(),
      profileState: MainProfileState(),
    );
  }

  MainPageState copyWith({
    final int currentPageIndex,
    final MainEventsState eventState,
    final MainReposState repoState,
    final MainIssuesState issueState,
    final MainProfileState profileState,
  }) {
    return MainPageState(
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      eventState: eventState ?? this.eventState,
      repoState: repoState ?? this.repoState,
      issueState: issueState ?? this.issueState,
      profileState: profileState ?? this.profileState,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainPageState &&
          runtimeType == other.runtimeType &&
          currentPageIndex == other.currentPageIndex &&
          eventState == other.eventState &&
          repoState == other.repoState &&
          issueState == other.issueState &&
          profileState == other.profileState;

  @override
  int get hashCode =>
      currentPageIndex.hashCode ^
      eventState.hashCode ^
      repoState.hashCode ^
      issueState.hashCode ^
      profileState.hashCode;

  @override
  String toString() {
    return 'MainPageState{currentPageIndex: $currentPageIndex, eventState: $eventState, repoState: $repoState, issueState: $issueState, profileState: $profileState}';
  }
}

abstract class MainPageStates {
  final int currentPageIndex;

  MainPageStates(this.currentPageIndex);

  static MainNormalState initial() {
    return MainNormalState(MainPageState.TAB_INDEX_EVENTS);
  }
}

class MainNormalState extends MainPageStates {
  MainNormalState(int newIndex) : super(newIndex);
}
