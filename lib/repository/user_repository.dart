import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_rhine/common/constants/constants.dart';
import 'package:flutter_rhine/common/model/user.dart';
import 'package:flutter_rhine/common/service/service_manager.dart';
import 'package:flutter_rhine/repository/others/sputils.dart';

import 'package:flutter_rhine/repository/others/dao_result.dart';

class UserRepository {
  /// 用户信息
  User _user;

  /// 用户token
  String _token;

  User get user => _user;

  String get token => _token;

  /// 用户是否自动登录
  Future<bool> hasAutoLoginInfo() async {
    final String usernameTemp = await SpUtils.get(Config.USER_NAME_KEY) ?? '';
    final String passwordTemp = await SpUtils.get(Config.PW_KEY) ?? '';

    return usernameTemp != '' && passwordTemp != '';
  }

  /// 获取用户自动登录信息
  Future<List<String>> fetchAutoLoginInfo() async {
    final String usernameTemp = await SpUtils.get(Config.USER_NAME_KEY) ?? '';
    final String passwordTemp = await SpUtils.get(Config.PW_KEY) ?? '';

    return [usernameTemp, passwordTemp];
  }

  /// 用户是否登录
  Future<bool> isLogin() async {
    return _token != null && _token != null;
  }

  /// 存储用户Token
  /// [token] 用户的token
  Future<void> persistToken(final String token) async {
    assert(token != null);
    this._token = token;
    return;
  }

  /// 存储用户信息
  Future<void> persistUserInfo(final User user) async {
    assert(user != null);
    this._user = user;
    return;
  }

  /// 用户登录
  /// [username] 用户名
  /// [password] 登录密码
  Future<DataResult<User>> login(
      final String username, final String password) async {
    if (username == null ||
        username == '' ||
        password == null ||
        password == '') {
      return DataResult.failure();
    }

    final String type = username + ":" + password;
    var bytes = utf8.encode(type);
    var base64Str = base64.encode(bytes);
    if (Config.DEBUG) {
      print("base64Str login " + base64Str);
    }

    final Map requestParams = {
      "scopes": ['user', 'repo'],
      "note": "admin_script",
      "client_id": Ignore.clientId,
      "client_secret": Ignore.clientSecret
    };
    logout();

    var res = await serviceManager.netFetch(Api.authorization,
        json.encode(requestParams), null, new Options(method: "post"));

    DataResult<User> resultData;
    if (res != null && res.result) {
      await SpUtils.save(Config.PW_KEY, password);
      resultData = await getUserInfo(null);

      if (Config.DEBUG) {
        print("user result " + resultData.result.toString());
        print(resultData.data);
        print(res.data.toString());
      }
    }

    return resultData;
  }

  /// 获取用户登录信息
  /// [userName] 查询对应username的用户信息，该参数为null时，请求用户自己的用户信息
  /// [needDb]   是否需要将用户信息存储数据库
  Future<DataResult<User>> getUserInfo(final String userName,
      {final bool needDb = false}) async {
    next() async {
      var res = await serviceManager.netFetch(Api.userInfo, null, null, null);
      if (res != null && res.result) {
        final User user = User.fromJson(res.data);

        // 存入持久层
        if (needDb) SpUtils.save(Config.USER_INFO, json.encode(user.toJson()));
        // 存入内存
        persistUserInfo(user);

        return DataResult(user, true);
      } else {
        return DataResult(res.data, false);
      }
    }

    return await next();
  }

  /// 退出登录
  Future<void> logout() async {
    this._token = null;
    this._user = null;
    return;
  }
}
