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
      var user = await Dio().get('http://10.0.2.2:8000/api/doctors',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // if request successfully, then return user data
      if (user.statusCode == 200 && user.data != '') {
        return jsonEncode(user.data);
      }
    } on DioException catch (error) {
      return error.response;
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
    String password,
    String bioData,
    String experienceYear,
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
          'password': password,
          'bio_data': bioData,
          'experience_year': experienceYear,
        },
      );

      if (response.statusCode == 201 && response.data != '') {
        return true;
      }
    } on DioException catch (error) {
      return error.response;
    }
  }

  Future<dynamic> updateAppointment(
    String token,
    int appointmentId,
    String status,
    DateTime date,
    String time,
    String additionalMessage,
  ) async {
    try {
      var response = await Dio().put(
        'http://10.0.2.2:8000/api/appointment/$appointmentId',
        data: {
          'status': status,
          'date': date.toIso8601String(),
          'time': time,
          'additional_message': additionalMessage,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200 && response.data != '') {
        return response;
      } else {
        return 'Response data: ${response.data}';
      }
    } on DioException catch (error) {
      return error.response;
    }
  }

  Future<dynamic> deleteDoctorAppointment(
    int appointmentId,
    String token,
  ) async {
    try {
      var response = await Dio().delete(
        'http://10.0.2.2:8000/api/appointment/$appointmentId',
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

  // PATIENT PAGE
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
    } on DioException catch (_) {
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
      var user = await Dio().get('http://10.0.2.2:8000/api/patients',
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
  Future<dynamic> bookAppointment(
    dynamic date,
    String time,
    String disease,
    int doctor,
    int specialization,
    String token,
  ) async {
    try {
      var response = await Dio().post('http://10.0.2.2:8000/api/book',
          data: {
            'date': date,
            'time': time,
            'disease': disease,
            'specialization': specialization,
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
        'http://10.0.2.2:8000/api/patient-profile',
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
        'http://10.0.2.2:8000/api/appointment/$appointmentId',
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

  Future<dynamic> updateDoctor(
    String token,
    int doctorId,
    String fullName,
    String userName,
    String phoneNo,
    int? specialization,
    String bioData,
    String experience,
    String? status,
  ) async {
    try {
      var response = await Dio().put(
        'http://10.0.2.2:8000/api/doctor/$doctorId',
        data: {
          'name': fullName,
          'user_name': userName,
          'phone_no': phoneNo,
          'specialization': specialization,
          'bio_data': bioData,
          'experience': experience,
          'status': status,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200 && response.data != '') {
        return response;
      } else {
        return 'Error';
      }
    } on DioException catch (error) {
      return error.response;
    }
  }

  Future<dynamic> updatePatientAppointmentStatus(
    int appointmentId,
    String token,
  ) async {
    try {
      var response = await Dio().put(
        'http://10.0.2.2:8000/api/appointment/$appointmentId/status',
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
        return false;
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
        'http://10.0.2.2:8000/api/appointment/$appointmentId',
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
        'http://10.0.2.2:8000/api/doctor/$doctorId/comments',
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
        'http://10.0.2.2:8000/api/image',
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
