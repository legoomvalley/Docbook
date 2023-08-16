import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/button.dart';
import 'package:flutter_docbook/main.dart';
import 'package:flutter_docbook/utils/config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../models/auth_model.dart';
import '../providers/dio_provider.dart';
import '../utils/form_error.dart';

class RegisterFormPatient extends StatefulWidget {
  const RegisterFormPatient({super.key});

  @override
  State<RegisterFormPatient> createState() => _RegisterFormPatientState();
}

class _RegisterFormPatientState extends State<RegisterFormPatient> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  bool obsecurePass = true;
  String? _userNameErr = '';
  String? _emailErr = '';
  String? _passwordErr = '';

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
            // validator: (value) {
            //   if (value != null && value.length < 7) {
            //     return 'Enter min. 7 characters';
            //   } else {
            //     return null;
            //   }
            // },
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
          Row(
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/');
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
                onPressed: () async {
                  final userRegistration = await DioProvider().registerPatient(
                    _fullNameController.text,
                    _userNameController.text,
                    _emailController.text,
                    _mobileNumberController.text,
                    _passwordController.text,
                  );

                  print(userRegistration.statusCode);

                  if (userRegistration.statusCode < 300) {
                    _emailErr = null;
                    _userNameErr = null;
                    _passwordErr = null;
                    if (_formKey.currentState!.validate()) {}
                    final token = await DioProvider().getTokenPatient(
                        _emailController.text, _passwordController.text);
                    if (token) {
                      auth.loginSuccess(); //update login status
                      // redirect to main page
                      MyApp.navigatorKey.currentState!.pushNamed('main');
                    }
                  } else if (userRegistration.statusCode == 400) {
                    setState(() {
                      _emailErr = userRegistration?.data['email'] != null
                          ? userRegistration?.data['email'].join('\n')
                          : null;
                      _userNameErr = userRegistration?.data['user_name'] != null
                          ? userRegistration?.data['user_name'].join('\n')
                          : null;
                      _passwordErr = userRegistration?.data['password'] != null
                          ? userRegistration?.data['password'].join('\n')
                          : null;
                      if (_formKey.currentState!.validate()) {}
                    });
                  }
                },
              );
            },
          ),
          Container(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('auth_doctor');
              },
              child: Text(
                'You\'re a doctor?',
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
