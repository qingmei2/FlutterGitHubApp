import 'package:flutter_rhine/common/common.dart';
import 'package:meta/meta.dart';

abstract class MainReposEvent {}

/// 第一次加载数据，默认按照更新时间排序
class MainReposInitialEvent extends MainReposEvent {
  final String username;
  final String sortType = UserRepoRepository.SORT_UPDATED;

  MainReposInitialEvent({
    @required this.username,
  }) : assert(username != null);
}

/// sort排序规则修改
class MainReposChangeFilterEvent extends MainReposEvent {
  final String username;
  final String sortType;

  MainReposChangeFilterEvent({
    @required this.username,
    @required this.sortType,
  }) : assert(sortType != null && username != null);
}

/// 加载更多
class MainReposLoadNextPageEvent extends MainReposEvent {
  final String username;

  MainReposLoadNextPageEvent({
    @required this.username,
  }) : assert(username != null);
}
