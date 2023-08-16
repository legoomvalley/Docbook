import 'dart:convert';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/button.dart';
import 'package:flutter_docbook/components/snackBar.dart';
import 'package:flutter_docbook/main.dart';
import 'package:flutter_docbook/utils/config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../models/auth_model.dart';
import '../providers/dio_provider.dart';
import '../utils/form_error.dart';

class RegisterFormDoctor extends StatefulWidget {
  const RegisterFormDoctor({super.key});

  @override
  State<RegisterFormDoctor> createState() => _RegisterFormDoctorState();
}

class _RegisterFormDoctorState extends State<RegisterFormDoctor> {
  _RegisterFormDoctorState() {
    _selectedSpecializationItems = _specializationItems[0]['index'];
    _selectedStatusItems = _statusItems[0];
  }
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _locationController = TextEditingController();
  bool obsecurePass = true;
  String? _userNameErr = '';
  String? _emailErr = '';
  String? _passwordErr = '';

  final List<Map<String, dynamic>> _specializationItems = [
    {'name': 'Pediatrics', 'index': 1},
    {'name': 'General Medicine', 'index': 2},
    {'name': 'Orthopedics', 'index': 3},
    {'name': 'Eye Specialist', 'index': 4}
  ];
  List<String> _statusItems = [
    'Available',
    'Not Available',
  ];
  int? _selectedSpecializationItems = 1;
  String? _selectedStatusItems = 'Available';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _fullNameController,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Full Name',
              labelText: 'Full Name',
              filled: true,
              fillColor: Color.fromRGBO(206, 222, 239, 1),
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.people_alt_outlined),
              prefixIconColor: Config.primaryColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
            validator: (value) {
              if (value == "") {
                return "full name field is required";
              } else {
                return null;
              }
            },
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _userNameController,
            cursorColor: Config.primaryColor,
            decoration: InputDecoration(
              hintText: 'Username',
              labelText: 'Username',
              filled: true,
              fillColor: Color.fromRGBO(206, 222, 239, 1),
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.person_2_outlined),
              prefixIconColor: Config.primaryColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
            validator: (value) {
              if (value != null) {
                return _userNameErr;
              } else {
                return null;
              }
            },
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: InputDecoration(
              hintText: 'Email Address',
              labelText: 'Email',
              filled: true,
              fillColor: Color.fromRGBO(206, 222, 239, 1),
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.email_outlined),
              prefixIconColor: Config.primaryColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
            validator: (value) {
              if (value != null) {
                return _emailErr;
              } else {
                return null;
              }
            },
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _mobileNumberController,
            cursorColor: Config.primaryColor,
            decoration: InputDecoration(
              hintText: 'Mobile Number',
              labelText: 'Mobile Number',
              filled: true,
              fillColor: Color.fromRGBO(206, 222, 239, 1),
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.phone_android_sharp),
              prefixIconColor: Config.primaryColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
            validator: (value) {
              if (value == "") {
                return "mobile number field is required";
              } else {
                return null;
              }
            },
          ),
          Config.spaceSmall,
          DropdownButtonFormField(
            value: _selectedSpecializationItems,
            decoration: InputDecoration(
              hintText: 'Specialization',
              labelText: 'Specialization',
              filled: true,
              fillColor: Color.fromRGBO(206, 222, 239, 1),
              alignLabelWithHint: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
            items: _specializationItems
                .map((e) =>
                    DropdownMenuItem(child: Text(e['name']), value: e['index']))
                .toList(),
            onChanged: (val) {
              setState(() {
                _selectedSpecializationItems = val as int;
              });
            },
          ),
          Config.spaceSmall,
          DropdownButtonFormField(
            value: _selectedStatusItems,
            decoration: InputDecoration(
              hintText: 'Status',
              labelText: 'Status',
              filled: true,
              fillColor: Color.fromRGBO(206, 222, 239, 1),
              alignLabelWithHint: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
            items: _statusItems
                .map((e) => DropdownMenuItem(child: Text(e), value: e))
                .toList(),
            onChanged: (val) {
              setState(() {
                _selectedStatusItems = val as String;
              });
            },
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Config.primaryColor,
            obscureText: obsecurePass,
            decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
              filled: true,
              fillColor: Color.fromRGBO(206, 222, 239, 1),
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.lock_outlined),
              prefixIconColor: Config.primaryColor,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obsecurePass = !obsecurePass;
                  });
                },
                icon: obsecurePass
                    ? const Icon(
                        Icons.visibility_off_outlined,
                        color: Colors.black38,
                      )
                    : const Icon(
                        Icons.visibility_outlined,
                        color: Config.primaryColor,
                      ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
            validator: (value) {
              if (value != null) {
                return _passwordErr;
              } else {
                return null;
              }
            },
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _locationController,
            cursorColor: Config.primaryColor,
            decoration: InputDecoration(
              hintText: 'Location',
              labelText: 'Location',
              filled: true,
              fillColor: Color.fromRGBO(206, 222, 239, 1),
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.location_on),
              prefixIconColor: Config.primaryColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
            validator: (value) {
              if (value == "") {
                return 'location field is required';
              } else {
                return null;
              }
            },
          ),
          Row(
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('auth_doctor');
                },
                child: Text(
                  textAlign: TextAlign.left,
                  'ALready have an account?',
                  style: GoogleFonts.openSans(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          // Config.spaceSmall,
          Consumer<AuthModel>(
            builder: (context, auth, child) {
              return Button(
                width: double.infinity,
                title: 'Register',
                disable: false,
                color: Config.primaryColor,
                backgroundColor: Color.fromRGBO(239, 247, 255, 1),
                borderRadius: BorderRadius.circular(0),
                // onPressed: () async {
                // final userRegistration = await DioProvider().registerDoctor(
                //   _fullNameController.text,
                //   _userNameController.text,
                //   _emailController.text,
                //   _mobileNumberController.text,
                //   _selectedSpecializationItems,
                //   _selectedStatusItems,
                //   _locationController.text,
                //   _passwordController.text,
                // );
                // print(userRegistration);

                // if (userRegistration.statusCode < 300) {
                //   _emailErr = null;
                //   _userNameErr = null;
                //   _passwordErr = null;
                //   snackBar(
                //     context,
                //     'your application has been sent, please wait for admin to approve.Kindly check your email for notification.',
                //     Color.fromRGBO(76, 175, 80, 1),
                //     Duration(seconds: 4),
                //   );
                //   if (_formKey.currentState!.validate()) {}
                // } else if (userRegistration.statusCode == 400) {
                //   setState(() {
                //     _emailErr = userRegistration?.data['email'] != null
                //         ? userRegistration?.data['email'].join('\n')
                //         : null;
                //     _userNameErr = userRegistration?.data['user_name'] != null
                //         ? userRegistration?.data['user_name'].join('\n')
                //         : null;
                //     _passwordErr = userRegistration?.data['password'] != null
                //         ? userRegistration?.data['password'].join('\n')
                //         : null;
                //     if (_formKey.currentState!.validate()) {}
                //   });
                // }

                onPressed: () {
                  Navigator.of(context).pushNamed('main_doctor');
                },
                // },
              );
            },
          ),
          Container(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/');
              },
              child: Text(
                'You\'re a patient?',
                style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
