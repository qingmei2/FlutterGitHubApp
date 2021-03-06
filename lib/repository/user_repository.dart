import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_rhine/common/common.dart';
import 'package:flutter_rhine/common/constants/constants.dart';
import 'package:flutter_rhine/common/model/user.dart';
import 'package:flutter_rhine/common/service/service_manager.dart';
import 'package:flutter_rhine/repository/others/dao_result.dart';
import 'package:flutter_rhine/repository/others/sputils.dart';

class UserRepository {
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

  /// 用户登录
  /// [username] 用户名
  /// [password] 登录密码
  Future<DataResult<User>> login(
      final String username, final String password) async {
    if (username == null ||
        username == '' ||
        password == null ||
        password == '') {
      return DataResult.failure(Errors.emptyInputException('用户名密码不能为空'));
    }

    final String type = username + ":" + password;
    var bytes = utf8.encode(type);
    var base64Str = base64.encode(bytes);
    if (Config.DEBUG) {
      print("base64Str login " + base64Str);
    }

    await SpUtils.save(Config.USER_BASIC_CODE, base64Str);

    final Map requestParams = {
      "scopes": ['user', 'repo'],
      "note": "admin_script",
      "client_id": Ignore.clientId,
      "client_secret": Ignore.clientSecret
    };

    var res = await serviceManager.netFetch(Api.authorization,
        json.encode(requestParams), null, new Options(method: "post"));

    if (res != null && res.result) {
      await SpUtils.save(Config.USER_NAME_KEY, username);
      await SpUtils.save(Config.PW_KEY, password);
      DataResult<User> resultData = await getUserInfo(null);

      if (Config.DEBUG) {
        print("user result " + resultData.result.toString());
        print(resultData.data);
        print(res.data.toString());
      }
      return resultData;
    } else {
      return DataResult.failure(Errors.loginFailureException());
    }
  }

  /// 获取用户登录信息
  /// [userName] 查询对应username的用户信息，该参数为null时，请求用户自己的用户信息
  /// [needDb]   是否需要将用户信息存储数据库
  Future<DataResult<User>> getUserInfo(final String userName,
      {final bool needDb = false}) async {
    final DataResult<dynamic> res =
        await serviceManager.netFetch(Api.userInfo, null, null, null);
    if (res != null && res.result) {
      final User user = User.fromJson(res.data.data);

      // 存入持久层
      if (needDb) SpUtils.save(Config.USER_INFO, json.encode(user.toJson()));

      return DataResult.success(user);
    } else {
      return DataResult.failure(Errors.loginFailureException());
    }
  }
}
