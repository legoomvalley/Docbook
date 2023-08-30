import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioProvider {
  // doctorpage
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

  Future<dynamic> getUserDoctor(String token) async {
    try {
      var user = await Dio().get('http://10.0.2.2:8000/api/doctor',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // if request successfully, then return user data
      if (user.statusCode == 200 && user.data != '') {
        return jsonEncode(user.data);
      }
    } catch (error) {
      return error;
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

  // patientpage
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
        return response;
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

  // get user data
  Future<dynamic> getUserPatient(String token) async {
    try {
      var user = await Dio().get('http://10.0.2.2:8000/api/patient',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // if request successfully, then return user data
      if (user.statusCode == 200 && user.data != '') {
        return jsonEncode(user.data);
      }
    } catch (error) {
      return error;
    }
  }

  // store booking details
  Future<dynamic> bookAppointment(dynamic date, String time, String disease,
      int doctor, String token) async {
    try {
      var response = await Dio().post('http://10.0.2.2:8000/api/book',
          data: {
            'date': date,
            'time': time,
            'disease': disease,
            'doctor_id': doctor
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // if request successfully, then return user data
      if (response.statusCode == 200 && response.data != 'data') {
        return response.statusCode;
      } else {
        return 'Error';
      }
    } on DioException catch (error) {
      return error.response;
    }
  }

  Future<dynamic> getAppointments(String token) async {
    try {
      var response = await Dio().get('http://10.0.2.2:8000/api/appointments',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 && response.data != '') {
        return json.encode(response.data);
      } else {
        return 'Error';
      }
    } catch (error) {
      return error;
    }
  }

  // update user profile
  Future<dynamic> updatePatientProfile(
    String token,
    String name,
    String mobileNumber,
  ) async {
    try {
      var response = await Dio().put(
        'http://10.0.2.2:8000/api/profile/update/patient',
        data: {
          'name': name,
          'phone_no': mobileNumber,
          // Add more fields you want to update
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      // if request successfully, then return response
      if (response.statusCode == 200 && response.data != '') {
        return response.data;
      } else {
        return 'Error';
      }
    } on DioException catch (error) {
      return error.response;
    }
  }

  Future<dynamic> updatePatientAppointment(
    int appointmentId,
    String date,
    String time,
    String disease,
    String token,
  ) async {
    try {
      var response = await Dio().put(
        'http://10.0.2.2:8000/api/appointment/update/$appointmentId',
        data: {
          'date': date,
          'time': time,
          'disease': disease,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200 && response.data != '') {
        return true;
      } else {
        return 'Error';
      }
    } catch (error) {
      return error;
    }
  }

  Future<dynamic> updatePatientAppointmentStatus(
    int appointmentId,
    String token,
  ) async {
    try {
      var response = await Dio().put(
        'http://10.0.2.2:8000/api/appointment/status/update/$appointmentId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200 && response.data != '') {
        return true;
      } else {
        return 'Error';
      }
    } catch (error) {
      return error;
    }
  }

  Future<dynamic> storeComment(
    int doctorId,
    String comment,
    String token,
  ) async {
    try {
      var response = await Dio().post('http://10.0.2.2:8000/api/comments',
          data: {'comment': comment, 'doctor_id': doctorId},
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200 && response.data != '') {
        return true;
      } else {
        return 'Error';
      }
    } on DioException catch (error) {
      return error.response;
    }
  }

  Future<dynamic> deletePatientAppointment(
    int appointmentId,
    String token,
  ) async {
    try {
      var response = await Dio().delete(
        'http://10.0.2.2:8000/api/appointment/delete/$appointmentId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200 && response.data != '') {
        return true;
      } else {
        return 'Error';
      }
    } on DioException catch (error) {
      return error.response;
    }
  }

  Future<dynamic> getCommentsForDoctor(int doctorId, String token) async {
    try {
      final response = await Dio().get(
        'http://10.0.2.2:8000/api/doctors/$doctorId/comments',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        return jsonEncode(response.data);
      }
    } catch (error) {
      return error;
    }
  }

  Future<dynamic> logout(String token) async {
    try {
      final response = await Dio().post(
        'http://10.0.2.2:8000/api/logout',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        return response.statusCode;
      }
    } on DioException catch (error) {
      return error.response;
    }
  }

  Future<dynamic> uploadProfileImage(String token, FormData formData) async {
    try {
      final response = await Dio().post(
        'http://10.0.2.2:8000/api/upload-image',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response.data;
    } on DioException catch (error) {
      return error.response;
    }
  }
}
