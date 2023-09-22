import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/button.dart';
import 'package:flutter_docbook/components/snackBar.dart';
import 'package:flutter_docbook/main.dart';
import 'package:flutter_docbook/utils/config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../models/auth_model.dart';
import '../../providers/dio_provider.dart';

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
  final _bioDataController = TextEditingController();
  final _experienceController = TextEditingController();
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
    'available',
    'not available',
  ];
  int? _selectedSpecializationItems = 1;
  String? _selectedStatusItems = 'available';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _fullNameController,
            cursorColor: Config.doctorTheme,
            decoration: const InputDecoration(
              hintText: 'Full Name',
              labelText: 'Full Name',
              filled: true,
              fillColor: Color.fromRGBO(94, 94, 184, 0.3),
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.people_alt_outlined),
              prefixIconColor: Config.doctorTheme,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Config.doctorTheme),
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
            cursorColor: Config.doctorTheme,
            decoration: const InputDecoration(
              hintText: 'Username',
              labelText: 'Username',
              filled: true,
              fillColor: Color.fromRGBO(94, 94, 184, 0.3),
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.person_2_outlined),
              prefixIconColor: Config.doctorTheme,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Config.doctorTheme),
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
            cursorColor: Config.doctorTheme,
            decoration: const InputDecoration(
              hintText: 'Email Address',
              labelText: 'Email',
              filled: true,
              fillColor: Color.fromRGBO(94, 94, 184, 0.3),
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.email_outlined),
              prefixIconColor: Config.doctorTheme,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Config.doctorTheme),
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
            cursorColor: Config.doctorTheme,
            decoration: const InputDecoration(
              hintText: 'Mobile Number',
              labelText: 'Mobile Number',
              filled: true,
              fillColor: Color.fromRGBO(94, 94, 184, 0.3),
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.phone_android_sharp),
              prefixIconColor: Config.doctorTheme,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Config.doctorTheme),
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
            decoration: const InputDecoration(
              hintText: 'Specialization',
              labelText: 'Specialization',
              filled: true,
              labelStyle: TextStyle(color: Color.fromRGBO(94, 94, 184, 0.3)),
              fillColor: Color.fromRGBO(94, 94, 184, 0.3),
              alignLabelWithHint: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Config.doctorTheme),
              ),
            ),
            items: _specializationItems
                .map((e) =>
                    DropdownMenuItem(value: e['index'], child: Text(e['name'])))
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
            decoration: const InputDecoration(
              hintText: 'Status',
              labelText: 'Status',
              filled: true,
              fillColor: Color.fromRGBO(94, 94, 184, 0.3),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Config.doctorTheme),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(color: Colors.red),
              hintStyle: TextStyle(color: Colors.grey),
            ),
            items: _statusItems
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
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
            cursorColor: Config.doctorTheme,
            obscureText: obsecurePass,
            decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
              filled: true,
              fillColor: const Color.fromRGBO(94, 94, 184, 0.3),
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.lock_outlined),
              prefixIconColor: Config.doctorTheme,
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
                        color: Config.doctorTheme,
                      ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Config.doctorTheme),
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
            controller: _bioDataController,
            maxLines: 5,
            cursorColor: Config.doctorTheme,
            decoration: const InputDecoration(
              hintText: 'Bio Data',
              labelText: 'Bio Data',
              filled: true,
              fillColor: Color.fromRGBO(94, 94, 184, 0.3),
              alignLabelWithHint: true,
              prefixIcon: Padding(
                  padding:
                      EdgeInsets.only(bottom: 80), // Adjust padding as needed
                  child: Icon(
                    Icons.medical_information,
                    color: Config.doctorTheme,
                  )),
              prefixIconColor: Config.doctorTheme,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Config.doctorTheme),
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
            controller: _experienceController,
            cursorColor: Config.doctorTheme,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Total Experience',
              labelText: 'Total Experience',
              filled: true,
              fillColor: Color.fromRGBO(94, 94, 184, 0.3),
              alignLabelWithHint: true,
              prefixIcon: Icon(
                Icons.medical_services,
                color: Config.doctorTheme,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Config.doctorTheme),
              ),
            ),
            validator: (value) {
              if (value == "") {
                return "Total Experience field is required";
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
                title: isLoading ? 'Please wait' : 'Register',
                elevation: 5,
                disable: isLoading ? true : false,
                color: Config.doctorTheme,
                backgroundColor: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(0),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  final userRegistration = await DioProvider().registerDoctor(
                    _fullNameController.text,
                    _userNameController.text,
                    _emailController.text,
                    _mobileNumberController.text,
                    _selectedSpecializationItems,
                    _selectedStatusItems,
                    _passwordController.text,
                    _bioDataController.text,
                    _experienceController.text,
                  );

                  if (userRegistration == true) {
                    setState(() {
                      _emailErr = null;
                      _userNameErr = null;
                      _passwordErr = null;
                    });
                    MyApp.navigatorKey.currentState!.pushNamed('auth_doctor');
                    setState(() {
                      isLoading = false;
                    });
                    snackBar(
                      context,
                      'your registration has been sent, please wait for admin to approve',
                      const Color.fromRGBO(76, 175, 80, 1),
                      const Duration(seconds: 5),
                    );
                    if (_formKey.currentState!.validate()) {}
                  } else if (userRegistration.statusCode == 400 ||
                      _formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = false;
                      _emailErr = userRegistration.data['email'] != null
                          ? userRegistration?.data['email'].join('\n')
                          : null;
                      _userNameErr = userRegistration.data['user_name'] != null
                          ? userRegistration?.data['user_name'].join('\n')
                          : null;
                      _passwordErr = userRegistration.data['password'] != null
                          ? userRegistration?.data['password'].join('\n')
                          : null;
                      if (_formKey.currentState!.validate()) {}
                    });
                  }
                },
              );
            },
          ),
          TextButton(
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
        ],
      ),
    );
  }
}
