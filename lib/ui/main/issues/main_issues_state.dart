import 'package:flutter_rhine/common/common.dart';

@immutable
class MainIssuesState {
  final bool isLoading;
  final int currentPage;
  final List<Issue> issues;
  final String listSort;
  final String listState;

  final Exception error;

  MainIssuesState({
    this.currentPage = 0,
    this.issues = const [],
    this.isLoading = false,
    this.listSort = IssuesRepository.SORT_UPDATED,
    this.listState = IssuesRepository.STATE_OPEN,
    this.error,
  }) : assert(currentPage != null);

  MainIssuesState copyWith({
    final bool isLoading,
    final int currentPage,
    final List<Issue> issues,
    final String listSort,
    final String listState,
    final Exception error,
  }) {
    return MainIssuesState(
      isLoading: isLoading ?? this.isLoading,
      currentPage: currentPage ?? this.currentPage,
      issues: issues ?? this.issues,
      listSort: listSort ?? this.listSort,
      listState: listState ?? this.listState,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainIssuesState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          currentPage == other.currentPage &&
          issues == other.issues &&
          listSort == other.listSort &&
          listState == other.listState &&
          error == other.error;

  @override
  int get hashCode =>
      isLoading.hashCode ^
      currentPage.hashCode ^
      issues.hashCode ^
      listSort.hashCode ^
      listState.hashCode ^
      error.hashCode;

  @override
  String toString() {
    return 'MainIssuesState{isLoading: $isLoading, currentPage: $currentPage, issues: $issues, listSort: $listSort, listState: $listState, error: $error}';
  }
}
