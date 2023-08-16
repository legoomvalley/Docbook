import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioProvider {
  // get token
  Future<dynamic> getTokenPatient(String email, String password) async {
    try {
      var response = await Dio().post('http://10.0.2.2:8000/api/login/patient',
          data: {'email': email, 'password': password});

      //if request successfully, then return token
      if (response.statusCode == 200 && response.data != '') {
        //store returned token into share preferences
        // for get other data later
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.data);
        // } else {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<dynamic> getTokenDoctor(String email, String password) async {
    try {
      var response = await Dio().post('http://10.0.2.2:8000/api/login/doctor',
          data: {'email': email, 'password': password});

      if (response.statusCode == 200 && response.data != '') {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.data);
        // } else {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  // add patient
  Future<dynamic> registerPatient(
    String fullName,
    String userName,
    String email,
    String mobileNumber,
    String password,
  ) async {
    try {
      var response = await Dio().post(
        'http://10.0.2.2:8000/api/register/patient',
        data: {
          'full_name': fullName,
          'user_name': userName,
          'email': email,
          'phone_no': mobileNumber,
          'password': password
        },
      );

      //if request successfully, then return token
      if (response.statusCode == 201 && response.data != '') {
        return response;
      }
    } on DioException catch (error) {
      // return error.response?.data['email'];
      return error.response;
      // return false;
    }
  }

  // add doctor
  Future<dynamic> registerDoctor(
    String fullName,
    String userName,
    String email,
    String mobileNumber,
    dynamic specialization,
    dynamic status,
    String location,
    String password,
  ) async {
    try {
      var response = await Dio().post(
        'http://10.0.2.2:8000/api/register/doctor',
        data: {
          'full_name': fullName,
          'user_name': userName,
          'email': email,
          'mobile_number': mobileNumber,
          'specialization': specialization,
          'status': status,
          'location': location,
          'password': password
        },
      );

      //if request successfully, then return token
      if (response.statusCode == 201 && response.data != '') {
        return response;
      }
    } on DioException catch (error) {
      // return error.response?.data['email'];
      return error.response;
      // return false;
    }
  }

  // get user data
  Future<dynamic> getUser(String token) async {
    try {
      var user = await Dio().get('http://10.0.2.2:8000/api/user',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // if request successfully, then return user data
      if (user.statusCode == 200 && user.data != '') {
        return json.encode(user.data);
      }
    } catch (error) {
      return error;
    }
  }
}
