import 'package:flutter_rhine/common/constants/config.dart';

class Api {
  static const String host = "https://api.github.com/";

  /// [POST]用户鉴权
  static const String authorization = "${host}authorizations";

  /// [GET]我的用户信息
  static const String userInfo = "${host}user";

  /// [GET]用户事件
  static String userEvents(final String username) =>
      "${host}users/$username/received_events";

  /// 处理分页参数
  /// [tab]      分隔符
  /// [page]     页数
  /// [pageSize] 每页请求数据量
  static getPageParams(tab, page, [pageSize = Config.PAGE_SIZE]) {
    if (page != null) {
      if (pageSize != null) {
        return "${tab}page=$page&per_page=$pageSize";
      } else {
        return "${tab}page=$page";
      }
    } else {
      return "";
    }
  }
}
