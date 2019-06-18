import 'package:dio/dio.dart';
import 'package:flutter_rhine/constants/config.dart';
import 'package:flutter_rhine/repository/sputils.dart';

class TokenInterceptor extends InterceptorsWrapper {
  String _token;

  @override
  onRequest(RequestOptions options) async {
    if (_token == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        _token = authorizationCode;
      }
    }
    options.headers["Authorization"] = _token;
    return options;
  }

  @override
  onResponse(Response response) async {
    try {
      var responseJson = response.data;
      if (response.statusCode == 201 && responseJson['token'] != null) {
        _token = 'token' + responseJson['token'];
        await SpUtils.save(Config.TOKEN_KEY, _token);
      }
    } catch (e) {
      print(e);
    }
    return response;
  }

  clearAuthorization() {
    this._token = null;
    SpUtils.remove(Config.TOKEN_KEY);
  }

  getAuthorization() async {
    final String token = await SpUtils.get(Config.TOKEN_KEY);
    if (token == null) {
      final String basic = await SpUtils.get(Config.USER_BASIC_CODE);
      if (basic == null) {
      } else {
        return "Basic $basic";
      }
    } else {
      this._token = token;
      return token;
    }
  }
}
