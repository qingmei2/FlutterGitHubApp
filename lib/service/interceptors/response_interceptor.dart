import 'package:dio/dio.dart';

import '../api_code.dart';
import '../result_data.dart';

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) {
    final RequestOptions option = response.request;
    try {
      if (option.contentType != null &&
          option.contentType.primaryType == 'text') {
        return ResultData(response.data, true, ApiCode.SUCCESS);
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ResultData(response.data, true, ApiCode.SUCCESS,
            headers: response.headers);
      }
    } catch (e) {
      print(e.toString() + option.path);
      return ResultData(response.data, false, response.statusCode,
          headers: response.headers);
    }
  }
}
