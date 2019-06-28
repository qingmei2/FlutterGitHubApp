import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rhine/common/constants/api.dart';
import 'package:flutter_rhine/common/constants/config.dart';
import 'package:flutter_rhine/common/constants/ignore.dart';
import 'package:flutter_rhine/common/model/user.dart';
import 'package:flutter_rhine/common/service/service_manager.dart';
import 'package:flutter_rhine/repository/dao_result.dart';
import 'package:flutter_rhine/repository/sputils.dart';

class LoginPageModel with ChangeNotifier {
  bool _progressVisible;
  bool _tryAutoLogin = true;
  String _username;
  String _password;

  bool get progressVisible => _progressVisible;

  String get username => _username;

  String get password => _password;

  void updateProgressVisible(final bool visible) {
    if (_progressVisible != visible) {
      _progressVisible = visible;
      notifyListeners();
    }
  }

  void onUserNameChanged(final String newValue) {
    if (_username != newValue) {
      _username = newValue;
      notifyListeners();
    }
  }

  void onPasswordChanged(final String newValue) {
    if (_password != newValue) {
      _password = newValue;
      notifyListeners();
    }
  }

  void updateTextField(
      final String newValue, final TextEditingController controller) {
    controller.text = newValue;
  }

  /// 用户自动登录
  /// [usernameController] 自动登录时会将上次登录的用户数据反映在ui上
  /// [passwordController] 同上
  /// [globalUserModel]    登录成功，将用户信息存储更新
  Future<DataResult> tryAutoLogin(
    final TextEditingController usernameController,
    final TextEditingController passwordController,
    final GlobalUserModel globalUserModel,
  ) async {
    if (!_tryAutoLogin) {
      return null;
    }
    _tryAutoLogin = false;

    final String usernameTemp = await SpUtils.get(Config.USER_NAME_KEY) ?? '';
    final String passwordTemp = await SpUtils.get(Config.PW_KEY) ?? '';

    if (usernameTemp == '' || passwordTemp == '') {
      return DataResult.failure();
    }

    // 将登录数据更新在ui上
    _username = usernameTemp;
    _password = passwordTemp;
    updateTextField(_username, usernameController);
    updateTextField(_password, passwordController);

    return login(globalUserModel);
  }

  /// 用户登录
  /// [globalUserModel]    登录成功，将用户信息存储更新
  Future<DataResult> login(final GlobalUserModel globalUserModel) async {
    if (progressVisible == true) {
      return new DataResult(null, false);
    }

    final String type = _username + ":" + _password;
    var bytes = utf8.encode(type);
    var base64Str = base64.encode(bytes);
    if (Config.DEBUG) {
      print("base64Str login " + base64Str);
    }

    await SpUtils.save(Config.USER_NAME_KEY, _username);
    await SpUtils.save(Config.USER_BASIC_CODE, base64Str);

    final Map requestParams = {
      "scopes": ['user', 'repo'],
      "note": "admin_script",
      "client_id": Ignore.clientId,
      "client_secret": Ignore.clientSecret
    };
    serviceManager.clearAuthorization();

    updateProgressVisible(true);

    var res = await serviceManager.netFetch(Api.authorization,
        json.encode(requestParams), null, new Options(method: "post"));
    var resultData;
    if (res != null && res.result) {
      await SpUtils.save(Config.PW_KEY, _password);
      resultData = await getUserInfo(null, globalUserModel);

      if (Config.DEBUG) {
        print("user result " + resultData.result.toString());
        print(resultData.data);
        print(res.data.toString());
      }
    }

    updateProgressVisible(false);

    return new DataResult(resultData, res.result);
  }

  /// 获取用户登录信息
  /// [userName] 查询对应username的用户信息，该参数为null时，请求用户自己的用户信息
  /// [globalUserModel]  登录成功，将用户信息存入内存
  /// [needDb]   是否需要将用户信息存储数据库
  getUserInfo(final String userName, final GlobalUserModel globalUserModel,
      {final bool needDb = false}) async {
    next() async {
      var res = await serviceManager.netFetch(Api.userInfo, null, null, null);
      if (res != null && res.result) {
        final User user = User.fromJson(res.data);

        // 存入持久层
        if (needDb) SpUtils.save(Config.USER_INFO, json.encode(user.toJson()));
        // 存入内存
        globalUserModel.persistUserInfo(user);
        
        return DataResult(user, true);
      } else {
        return DataResult(res.data, false);
      }
    }

    return await next();
  }
}
