import 'dart:io';

import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  bool _isLogin = false;
  String token = '';
  Map<String, dynamic> user = {}; // update user when login
  Map<String, dynamic> doctor = {}; // update user when login

  bool get isLogin {
    return _isLogin;
  }

  Map<String, dynamic> get getUser {
    return user;
  }

  Map<String, dynamic> get getDoctor {
    return doctor;
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

  void success(Map<String, dynamic> userData, String tokenData) {
    //update all these data when login
    user = userData;
    token = tokenData;
    notifyListeners();
  }

  void loginSuccessDoctor(Map<String, dynamic> userData, String tokenData,
      Map<String, dynamic> doctorData) {
    _isLogin = true;
    //update all these data when login
    user = userData;
    token = tokenData;
    doctor = doctorData;
    notifyListeners();
  }
}
