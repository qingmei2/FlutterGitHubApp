/// 自定义异常管理类
///
/// 开发者实例化类似[EmptyListException]、[LoginFailureException]不应该直接通过new的
/// 方式，而是使用[Errors]类提供的接口.
abstract class Errors {
  factory Errors._() => null;

  static EmptyListException emptyListException() {
    return EmptyListException();
  }

  static LoginFailureException loginFailureException() {
    return LoginFailureException();
  }

  static EmptyInputException emptyInputException(final String message) {
    return EmptyInputException(message);
  }

  static NetworkRequestException networkException({
    final String message,
    final int statusCode = 400,
  }) {
    return NetworkRequestException(message, statusCode);
  }
}

/// 服务器请求错误
class NetworkRequestException implements Exception {
  final String message;
  final int statusCode;

  NetworkRequestException(this.message, this.statusCode);
}

/// 空数据集错误
class EmptyListException implements Exception {}

/// 用户账号密码错误
class LoginFailureException implements Exception {
  final String message = '账号密码错误';
}

/// 输入为空错误
class EmptyInputException implements Exception {
  final String message;

  EmptyInputException(this.message);
}
