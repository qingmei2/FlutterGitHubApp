class Api {
  static const String host = "https://api.github.com/";

  /// [POST]用户鉴权
  static const String authorization = "${host}authorizations";

  /// [GET]我的用户信息
  static const String userInfo = "${host}user";
}
