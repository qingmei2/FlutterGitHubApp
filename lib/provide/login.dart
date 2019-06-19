import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rhine/constants/api.dart';
import 'package:flutter_rhine/constants/config.dart';
import 'package:flutter_rhine/constants/ignore.dart';
import 'package:flutter_rhine/dao/dao_result.dart';
import 'package:flutter_rhine/model/user.dart';
import 'package:flutter_rhine/repository/sputils.dart';
import 'package:flutter_rhine/service/service_manager.dart';

class LoginProvide with ChangeNotifier {
  String username;
  String password;

  void onUserNameChanged(final String newValue) {
    if (username != newValue) {
      username = newValue;
      notifyListeners();
    }
  }

  void onPasswordChanged(final String newValue) {
    if (password != newValue) {
      password = newValue;
      notifyListeners();
    }
  }

  /// 用户登录
  login() async {
    final String type = username + ":" + password;
    var bytes = utf8.encode(type);
    var base64Str = base64.encode(bytes);
    if (Config.DEBUG) {
      print("base64Str login " + base64Str);
    }

    await SpUtils.save(Config.USER_NAME_KEY, username);
    await SpUtils.save(Config.USER_BASIC_CODE, base64Str);

    final Map requestParams = {
      "scopes": ['user', 'repo', 'gist', 'notifications'],
      "note": "admin_script",
      "client_id": Ignore.clientId,
      "client_secret": Ignore.clientSecret
    };
    serviceManager.clearAuthorization();

    var res = await serviceManager.netFetch(Api.authorization,
        json.encode(requestParams), null, new Options(method: "post"));
    var resultData = null;
    if (res != null && res.result) {
      await SpUtils.save(Config.PW_KEY, password);
      var resultData = await getUserInfo(null);

      if (Config.DEBUG) {
        print("user result " + resultData.result.toString());
        print(resultData.data);
        print(res.data.toString());
      }
    }
    return new DataResult(resultData, res.result);
  }

  /// 获取用户登录信息
  getUserInfo(final String userName, {bool needDb = false}) async {
    next() async {
      var res = await serviceManager.netFetch(Api.userInfo, null, null, null);
      if (res != null && res.result) {
        final User user = User.fromJson(res.data);
        SpUtils.save(Config.USER_INFO, json.encode(user.toJson()));
        return DataResult(user, true);
      } else {
        return DataResult(res.data, false);
      }
    }

    return await next();
  }
}

enum LoginPageEvent {
  /// 用户名为空
  emptyUsernameInput,

  /// 密码为空
  emptyPasswordInput,

  /// 账号密码错误
  loginFailedWithAuthError
}
