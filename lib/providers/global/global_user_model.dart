import 'package:flutter/material.dart';
import 'package:flutter_rhine/model/user.dart';

class GlobalUserModel with ChangeNotifier {
  User _user;

  User get user => _user;

  void saveUserInfo(final User user) {
    this._user = user;
    notifyListeners();
  }
}
