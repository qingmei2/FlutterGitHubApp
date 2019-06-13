import 'dart:_http';

import 'package:dio/dio.dart';
import 'package:flutter_rhine/constants/api.dart';

final Dio dio = Dio();

Future request(url, {formData, ContentType contentType}) async {
  try {
    Response response;

    if (contentType == null) {
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded");
    } else {
      dio.options.contentType = contentType;
    }
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.......');
    }
  } catch (e) {
    return print('ERROR:======>$e');
  }
}
