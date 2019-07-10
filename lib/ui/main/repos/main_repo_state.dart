import 'package:flutter_rhine/common/common.dart';
import 'package:meta/meta.dart';

@immutable
class MainReposState {
  final bool isLoading;
  final int currentPage;
  final List<Repo> repos;
  final String sortType;

  final Exception error;

  MainReposState({
    this.currentPage = 0,
    this.repos = const [],
    this.isLoading = false,
    this.sortType = UserRepoRepository.SORT_UPDATED,
    this.error,
  }) : assert(currentPage != null);

  MainReposState copyWith({
    final bool isLoading,
    final int currentPage,
    final List<Repo> repos,
    final String sortType,
    final Exception error,
  }) {
    return MainReposState(
      isLoading: isLoading ?? this.isLoading,
      currentPage: currentPage ?? this.currentPage,
      repos: repos ?? this.repos,
      sortType: sortType ?? this.sortType,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'MainReposState{isLoading: $isLoading, currentPage: $currentPage, repos: $repos, sortType: $sortType, error: $error}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainReposState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          currentPage == other.currentPage &&
          repos == other.repos &&
          sortType == other.sortType &&
          error == other.error;

  @override
  int get hashCode =>
      isLoading.hashCode ^
      currentPage.hashCode ^
      repos.hashCode ^
      sortType.hashCode ^
      error.hashCode;
}

abstract class MainReposStates {
  final bool isLoading;
  final int currentPage;
  final List<Repo> repos;
  final String sortType;

  MainReposStates({
    @required this.currentPage,
    this.repos,
    this.isLoading = false,
    this.sortType = UserRepoRepository.SORT_UPDATED,
  }) : assert(currentPage != null);
}
