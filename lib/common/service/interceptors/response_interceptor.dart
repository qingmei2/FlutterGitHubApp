import 'package:dio/dio.dart';
import 'package:flutter_rhine/common/errors/errors.dart';
import 'package:flutter_rhine/repository/others/dao_result.dart';

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) {
    final RequestOptions option = response.request;
    try {
      if (option.contentType != null &&
          option.contentType.primaryType == 'text') {
        return DataResult.success(response.data);
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return DataResult.success(response.data);
      }
    } catch (e) {
      print(e.toString() + option.path);
      final networkError =
          NetworkRequestException('network error', response.statusCode);
      return DataResult.failure(networkError);
    }
  }
}
