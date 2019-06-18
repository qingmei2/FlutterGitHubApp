import 'dart:collection';

import 'package:dio/dio.dart';

class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  final Dio _dio = Dio();

  HttpManager() {
  }
}

Future request(String url, params, Map<String, dynamic> header, Options option,
    {noTip = false}) async {
  Map<String, dynamic> headers = HashMap();


}
