import 'package:flutter_rhine/common/common.dart';
import 'package:flutter_rhine/common/model/issue.dart';
import 'package:flutter_rhine/common/service/service_manager.dart';
import 'package:flutter_rhine/repository/others/dao_result.dart';

/// 用户issues相关
class IssuesRepository {
  IssuesRepository._();

  static const String SORT_CREATED = 'created';
  static const String SORT_UPDATED = 'updated';
  static const String SORT_COMMENTS = 'comments';

  static const String STATE_OPEN = 'open';
  static const String STATE_CLOSED = 'closed';
  static const String STATE_ALL = 'all';

  /// 获取用户issues列表
  /// [sort] 排序规则,[SORT_CREATED]、[SORT_UPDATED]、[SORT_COMMENTS]
  /// [state] issue状态,[STATE_OPEN]、[STATE_CLOSED]、[STATE_ALL]
  /// [page] 页数
  /// [perPage] 分页请求数量
  static Future<DataResult<List<Issue>>> fetchIssues({
    String sort = SORT_CREATED,
    String state = STATE_ALL,
    @required int page,
    int perPage = Config.PAGE_SIZE,
  }) async {
    _verifyIssuesApiParams(sort, state);

    final String url = Api.userIssues +
        Api.getPageParams('?', page, perPage) +
        '&sort=$sort&common.state=$state';

    DataResult res = await serviceManager.netFetch(url, null, null, null);
    if (res != null && res.result) {
      List<Issue> list = new List();
      var data = res.data;
      if (data == null || data.length == 0) {
        return DataResult.failure(Errors.emptyListException());
      }
      for (int i = 0; i < data.length; i++) {
        list.add(Issue.fromJson(data[i]));
      }
      return DataResult.success(list);
    } else {
      return DataResult.failure(Errors.networkException(statusCode: 400));
    }
  }

  static void _verifyIssuesApiParams(final String sort, final String state) {
    if (![SORT_CREATED, SORT_UPDATED, SORT_COMMENTS].contains(sort)) {
      throw Exception('错误的sort参数，请使用SORT_CREATED、SORT_UPDATED、SORT_COMMENTS');
    }
    if (![STATE_OPEN, STATE_CLOSED, STATE_ALL].contains(state)) {
      throw Exception(
          '错误的 common.state 参数，请使用SORT_CREATED、SORT_UPDATED、SORT_COMMENTS');
    }
  }
}
