import 'package:flutter_rhine/common/common.dart';
import 'package:meta/meta.dart';

@immutable
class MainEventsState {
  final bool isLoading;
  final int currentPage;
  final List<Event> events;

  final Exception error;

  MainEventsState({
    this.isLoading = false,
    this.currentPage = 0,
    this.events = const [],
    this.error,
  });

  MainEventsState copyWith({
    final bool isLoading,
    final int currentPage,
    final List<Event> events,
    final Exception error,
  }) {
    return MainEventsState(
      isLoading: isLoading ?? this.isLoading,
      currentPage: currentPage ?? this.currentPage,
      events: events ?? this.events,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainEventsState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          currentPage == other.currentPage &&
          events == other.events &&
          error == other.error;

  @override
  int get hashCode =>
      isLoading.hashCode ^
      currentPage.hashCode ^
      events.hashCode ^
      error.hashCode;

  @override
  String toString() {
    return 'MainEventsState{isLoading: $isLoading, currentPage: $currentPage, events: $events, error: $error}';
  }
}
