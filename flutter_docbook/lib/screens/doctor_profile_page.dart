// ignore_for_file: prefer_const_literals_to_create_immutables, duplicate_ignore, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/profile_text_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../components/button.dart';
import '../models/auth_model.dart';
import '../utils/config.dart';

class DoctorProfilePage extends StatefulWidget {
  const DoctorProfilePage({super.key});

  @override
  State<DoctorProfilePage> createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  // ignore: unused_field
  // fullName, username, mobile_number, specialization, status, location, bio_data, experience_year

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
  final _bioDataController = TextEditingController();

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  // color: Config.primaryColor,
                  height: 200.0,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Config.doctorTheme,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                      bottom: Radius.circular(30),
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              'Your profile',
                              style: GoogleFonts.openSans(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('assets/user.jpg'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 40, right: 20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Personal information',
                    style: GoogleFonts.openSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5),
                  Form(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                          decoration: InputDecoration(
                            hintText: 'Specialization',
                            labelText: 'Specialization',
                            filled: true,
                            fillColor: Color.fromRGBO(206, 222, 239, 1),
                            alignLabelWithHint: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                          items: _specializationItems
                              .map((e) => DropdownMenuItem(
                                  child: Text(e['name']), value: e['index']))
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                          items: _statusItems
                              .map((e) =>
                                  DropdownMenuItem(child: Text(e), value: e))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              _selectedStatusItems = val as String;
                            });
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                        Config.spaceSmall,
                        TextFormField(
                          controller: _bioDataController,
                          maxLines: 5,
                          cursorColor: Config.primaryColor,
                          decoration: InputDecoration(
                            hintText: 'Bio Data',
                            labelText: 'Bio Data',
                            filled: true,
                            fillColor: Color.fromRGBO(206, 222, 239, 1),
                            alignLabelWithHint: true,
                            prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                    bottom: 80), // Adjust padding as needed
                                child: Icon(
                                  Icons.medical_information,
                                  color: Config.primaryColor,
                                )),
                            prefixIconColor: Config.primaryColor,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// fullName, username, mobile_number, specialization, status, location, bio_data, experience_year