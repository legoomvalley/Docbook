import 'dart:io';

import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  bool _isLogin = false;
  String token = '';
  Map<String, dynamic> user = {}; // update user when login

  bool get isLogin {
    return _isLogin;
  }

  Map<String, dynamic> get getUser {
    return user;
  }

  String get getToken {
    return token;
  }

  void updateUser(Map<String, dynamic> updatedUserData) {
    user = updatedUserData;
    notifyListeners();
  }

  // when login success, update the status
  void loginSuccess(Map<String, dynamic> userData, String tokenData) {
    _isLogin = true;
    //update all these data when login
    user = userData;
    token = tokenData;
    notifyListeners();
  }
}
