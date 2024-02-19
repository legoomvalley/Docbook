import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_docbook/providers/dio_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/button.dart';
import '../components/confirmation_dialog.dart';
import '../components/snackBar.dart';
import '../main.dart';
import '../models/auth_model.dart';
import '../utils/config.dart';

class DoctorProfilePage extends StatefulWidget {
  const DoctorProfilePage({this.userData});
  final Map<String, dynamic>? userData;

  @override
  State<DoctorProfilePage> createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  // user_id 1
  // fullName, username, mobile_number, specialization, status, location, bio_data, experience_year

  Map<String, dynamic> user = {};
  List<dynamic> doctorBefore = [];
  dynamic doctor;
  String globalToken = "";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _bioDataController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  int? _selectedSpecializationItems;
  String? _selectedStatusItems = 'Available';
  final String _userNameErr = '';
  File? _pickedImage;
  bool isLoading = false;

  bool _fullNamechanged = false;
  bool _userNamechanged = false;
  bool _mobileNumberChanged = false;
  bool _bioDataChanged = false;
  bool _experienceChanged = false;

  final List<Map<String, dynamic>> _specializationItems = [
    {'name': 'Pediatrics', 'index': 1},
    {'name': 'General Medicine', 'index': 2},
    {'name': 'Orthopedics', 'index': 3},
    {'name': 'Eye Specialist', 'index': 4}
  ];
  final List<String> _statusItems = [
    'available',
    'not available',
  ];

  Future<void> getData() async {
    setState(() {
      user = Provider.of<AuthModel>(context, listen: false).getUser;
      globalToken = Provider.of<AuthModel>(context, listen: false).getToken;
      doctorBefore = user['doctor'];
      doctor = doctorBefore[0];

      _fullNameController.text = user['name'];
      _userNameController.text = doctor['user_name'];
      _mobileNumberController.text = doctor['mobile_number'];
      _selectedSpecializationItems = doctor['specialization_id'];
      _selectedStatusItems = doctor['status'];
      _bioDataController.text = doctor['bio_data'];
      _experienceController.text = doctor['experience_year'].toString();
    });
  }

  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 5);
    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
        print(_pickedImage);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Config.doctorTheme,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    // color: Config.primaryColor,
                    height: 200.0,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Config.doctorTheme,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),
                    ),
                    child: SafeArea(
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[
                          const Padding(padding: EdgeInsets.only(top: 20)),
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
                              const SizedBox(height: 10),
                            ],
                          ),
                          Stack(
                            children: [
                              SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Container(
                                      child: _pickedImage != null
                                          ? CircleAvatar(
                                              radius: 50,
                                              backgroundImage:
                                                  FileImage(_pickedImage!),
                                            )
                                          : user['profile_photo_path'] != null
                                              ? CircleAvatar(
                                                  radius: 50,
                                                  backgroundImage:NetworkImage(
                                                    'http://10.0.2.2:8000/storage/${user['profile_photo_path']}',
                                                  ),
                                                )
                                              : const CircleAvatar(
                                                  radius: 50,
                                                  backgroundImage: AssetImage(
                                                      'assets/user.jpg'),
                                                ))),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 40, left: 70),
                                color: Colors.white30,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    child: IconButton(
                                      icon: const Icon(Icons.camera_alt),
                                      onPressed: () => pickImage(),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, top: 40, right: 20),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Update Information',
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Theme(
                      data: ThemeData(primaryColor: Colors.grey),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                              cursorColor: Colors.grey,
                              controller: _fullNameController,
                              decoration: InputDecoration(
                                labelText: 'Full Name',
                                labelStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                hintText: '',
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                alignLabelWithHint: true,
                                suffixIcon:
                                    const Icon(Icons.people_alt_outlined),
                                suffixIconColor: Colors.grey,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  newValue != doctor['name']
                                      ? _fullNamechanged = true
                                      : _fullNamechanged = false;
                                });
                              },
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
                              decoration: InputDecoration(
                                labelText: 'Username',
                                filled: true,
                                labelStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                fillColor: Colors.grey.shade100,
                                alignLabelWithHint: true,
                                suffixIcon: const Icon(Icons.person_2_outlined),
                                suffixIconColor: Colors.grey,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  newValue != doctor['user_name']
                                      ? _userNamechanged = true
                                      : _userNamechanged = false;
                                });
                              },
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
                              controller: _mobileNumberController,
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                hintText: '',
                                labelText: 'Mobile Number',
                                filled: true,
                                labelStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                fillColor: Colors.grey.shade100,
                                alignLabelWithHint: true,
                                suffixIcon:
                                    const Icon(Icons.phone_android_sharp),
                                suffixIconColor: Colors.grey,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  newValue != doctor['mobile_number']
                                      ? _mobileNumberChanged = true
                                      : _mobileNumberChanged = false;
                                });
                              },
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
                                hintText: '',
                                labelText: 'Specialization',
                                filled: true,
                                labelStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                fillColor: Colors.grey.shade100,
                                alignLabelWithHint: true,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              items: _specializationItems
                                  .map((e) => DropdownMenuItem(
                                      value: e['index'],
                                      child: Text(e['name'])))
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
                                hintText: '',
                                labelText: 'Status',
                                filled: true,
                                labelStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                fillColor: Colors.grey.shade100,
                                alignLabelWithHint: true,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              items: _statusItems
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text(e)))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  _selectedStatusItems = val as String;
                                });
                              },
                            ),
                            Config.spaceSmall,
                            TextFormField(
                              controller: _bioDataController,
                              maxLines: 5,
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                hintText: '',
                                labelText: 'Bio Data',
                                filled: true,
                                labelStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                fillColor: Colors.grey.shade100,
                                alignLabelWithHint: true,
                                suffixIcon: const Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 80), // Adjust padding as needed
                                    child: Icon(
                                      Icons.medical_information,
                                      color: Colors.grey,
                                    )),
                                suffixIconColor: Colors.grey,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  newValue != doctor['bio_data']
                                      ? _bioDataChanged = true
                                      : _bioDataChanged = false;
                                });
                              },
                              validator: (value) {
                                if (value == '') {
                                  return 'bio data field is required';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            Config.spaceSmall,
                            TextFormField(
                              controller: _experienceController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2)
                              ],
                              cursorColor: Colors.grey,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: '',
                                labelText: 'Total Experience',
                                filled: true,
                                labelStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                fillColor: Colors.grey.shade100,
                                alignLabelWithHint: true,
                                suffixIcon: const Icon(
                                  Icons.medical_services,
                                  color: Colors.grey,
                                ),
                                suffixIconColor: Colors.grey,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  newValue !=
                                          doctor['experience_year'].toString()
                                      ? _experienceChanged = true
                                      : _experienceChanged = false;
                                });
                              },
                              validator: (value) {
                                if (value == '') {
                                  return 'experience field is required';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            Config.spaceSmall,
                            Button(
                                width: double.infinity,
                                title: isLoading ? 'Saving...' : 'Save',
                                disable: _fullNamechanged ||
                                        _userNamechanged == true ||
                                        _mobileNumberChanged ||
                                        (_selectedSpecializationItems !=
                                            doctor['specialization_id']) ||
                                        (_selectedStatusItems !=
                                            doctor['status']) ||
                                        _bioDataChanged ||
                                        _experienceChanged ||
                                        _pickedImage != null
                                    ? false
                                    : true,
                                color: Colors.white,
                                backgroundColor: Config.doctorTheme,
                                onPressed: () async {
                                  final authModel = Provider.of<AuthModel>(
                                      context,
                                      listen: false);
                                  if (_pickedImage != null) {
                                    FormData formData = FormData.fromMap({
                                      'profile_photo':
                                          await MultipartFile.fromFile(
                                              _pickedImage!.path),
                                    });

                                    final image = await DioProvider()
                                        .uploadProfileImage(
                                            globalToken, formData);

                                    final updatedUser = {
                                      ...authModel.getUser,
                                      'profile_photo_path': image
                                    };
                                    authModel.updateUser(updatedUser);
                                  }
                                  authModel.updateUser({
                                    ...authModel.getUser,
                                    'name': _fullNameController.text,
                                    'doctor': [
                                      {
                                        ...authModel.getUser['doctor'][0],
                                        'user_name': _userNameController.text,
                                        'mobile_number':
                                            _mobileNumberController.text,
                                        'specialization_id':
                                            _selectedSpecializationItems,
                                        'status': _selectedStatusItems,
                                        'bio_data': _bioDataController.text,
                                        'experience_year':
                                            _experienceController.text
                                      },
                                    ],
                                  });

                                  await DioProvider().updateDoctor(
                                    globalToken,
                                    user['id'],
                                    _fullNameController.text,
                                    _userNameController.text,
                                    _mobileNumberController.text,
                                    _selectedSpecializationItems,
                                    _bioDataController.text,
                                    _experienceController.text,
                                    _selectedStatusItems,
                                  );
                                  final updatedData = {
                                    'name': _fullNameController.text
                                  };
                                  snackBar(context, 'data successfully updated',
                                      Colors.green, const Duration(seconds: 4));
                                  await getData();
                                  Navigator.pop(context, updatedData);

                                  // if (_formKey.currentState!.validate()) {}
                                },
                                borderRadius: BorderRadius.circular(5),
                                elevation: 5),
                            Button(
                                width: double.infinity,
                                title: 'Logout',
                                disable: false,
                                color: Colors.white,
                                backgroundColor: Colors.red.shade500,
                                onPressed: () async {
                                  await showConfirmationDialog(
                                      context, 'Logout', () async {
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    final token =
                                        prefs.getString('token') ?? '';
                                    if (token.isNotEmpty && token != '') {
                                      final response =
                                          await DioProvider().logout(token);
                                      if (response == 200) {
                                        await prefs.remove('token');
                                        setState(() {
                                          MyApp.navigatorKey.currentState!
                                              .pushReplacementNamed('/');
                                        });
                                      }
                                    }
                                  });
                                },
                                borderRadius: BorderRadius.circular(5),
                                elevation: 5),
                            Config.spaceSmall
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
