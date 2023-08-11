import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  bool _isLogin = false;

  bool get isLogin {
    return _isLogin;
  }

  // when login success, update the status
  void loginSuccess() {
    _isLogin = true;
    notifyListeners();
  }
}
