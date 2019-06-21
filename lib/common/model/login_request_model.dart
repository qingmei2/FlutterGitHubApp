import 'package:flutter_rhine/common/constants/ignore.dart';

/// github login api params.
class LoginRequestModel {
  List<String> scopes;
  String note;
  String clientId;
  String clientSecret;

  LoginRequestModel._internal(
      this.scopes, this.note, this.clientId, this.clientSecret);

  factory LoginRequestModel() {
    return LoginRequestModel._internal(
        ['user', 'repo', 'gist', 'notifications'],
        Ignore.clientId,
        Ignore.clientId,
        Ignore.clientSecret);
  }
}
