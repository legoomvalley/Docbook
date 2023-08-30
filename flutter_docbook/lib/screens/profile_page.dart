// ignore_for_file: prefer_const_literals_to_create_immutables, duplicate_ignore, prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_docbook/components/confirmation_dialog.dart';
import 'package:flutter_docbook/components/snackBar.dart';
import 'package:flutter_docbook/components/button.dart';
import 'package:flutter_docbook/components/profile_text_field.dart';
import 'package:flutter_docbook/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_model.dart';
import '../providers/dio_provider.dart';
import '../utils/config.dart';

typedef void DataRefreshCallback();

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _pickedImage;

  Map<String, dynamic> user = {};
  String globalToken = "";

  final _formKey = GlobalKey<FormState>();

  bool editableNameTextField = false;
  bool editableContactNumberTextField = false;
  bool editableEmailTextField = false;

  // final TextEditingController _searchController = TextEditingController();
  String _contactNumberInput = "";
  String _nameInput = "";
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactNumberController = TextEditingController();
  bool isLoading = false;

  Future<void> getData() async {
    setState(() {
      user = Provider.of<AuthModel>(context, listen: false).getUser;
      globalToken = Provider.of<AuthModel>(context, listen: false).getToken;

      _nameController.text = user['name'];
      _contactNumberController.text = user['mobile_number'];
      editableNameTextField = false;
      editableContactNumberTextField = false;
    });
  }

  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
    }
  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Config().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: user.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 200.0,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Config.primaryColor,
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
                                              : user['profile_photo_path'] !=
                                                      null
                                                  ? CircleAvatar(
                                                      radius: 50,
                                                      backgroundImage:
                                                          NetworkImage(
                                                        'http://10.0.2.2:8000/storage/${user['profile_photo_path']}',
                                                      ),
                                                    )
                                                  : CircleAvatar(
                                                      radius: 50,
                                                      backgroundImage:
                                                          AssetImage(
                                                              'assets/user.jpg'),
                                                    ))
                                      // CircleAvatar(
                                      //     radius: 30,
                                      //     backgroundImage: user['profile_photo_path'] !=
                                      //             null
                                      //         ? AssetImage(user['profile_photo_path'])
                                      //         : AssetImage('assets/user.jpg')),
                                      ),
                                  Container(
                                    margin: EdgeInsets.only(top: 40, left: 70),
                                    color: Colors.white30,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        child: IconButton(
                                          icon: Icon(Icons.camera_alt),
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
                    margin: EdgeInsets.only(left: 20, top: 40, right: 20),
                    // width: double.infinity,
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
                          child: Column(children: [
                            ProfileTextField(
                              labelText: 'name',
                              textField: editableNameTextField
                                  ? TextFormField(
                                      autofocus: true,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w200),
                                      controller: _nameController,
                                      onChanged: (newValue) {
                                        setState(() {
                                          !editableNameTextField
                                              ? _nameInput = user['name']
                                              : _nameInput = newValue;
                                        });
                                      },
                                      cursorColor: Config.primaryColor,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            left: 0, bottom: 14),
                                        focusedBorder: InputBorder
                                            .none, // No border when focused
                                        enabledBorder: InputBorder.none,
                                      ),
                                    )
                                  : Text(
                                      user['name'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w200),
                                    ),
                              iconButton: IconButton(
                                onPressed: () {
                                  setState(() {
                                    editableNameTextField =
                                        !editableNameTextField;
                                    _nameController.text = user['name'];
                                    _nameInput = user['name'];
                                  });
                                },
                                padding: EdgeInsets.all(0),
                                icon: !editableNameTextField
                                    ? Icon(Icons.mode_edit_sharp)
                                    : Icon(Icons.cancel),
                              ),
                            ),
                            ProfileTextField(
                              labelText: 'Contact Number',
                              textField: editableContactNumberTextField
                                  ? TextFormField(
                                      autofocus: true,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _contactNumberInput = newValue;
                                        });
                                      },
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w200),
                                      controller: _contactNumberController,
                                      cursorColor: Config.primaryColor,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            left: 0, bottom: 14),
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                      ),
                                    )
                                  : Text(
                                      user['mobile_number'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w200),
                                    ),
                              iconButton: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      editableContactNumberTextField =
                                          !editableContactNumberTextField;
                                      _contactNumberController.text =
                                          user['mobile_number'];
                                      _contactNumberInput =
                                          user['mobile_number'];
                                    });
                                  },
                                  padding: EdgeInsets.all(0),
                                  icon: !editableContactNumberTextField
                                      ? Icon(Icons.mode_edit_sharp)
                                      : Icon(Icons.cancel)),
                            ),
                            SizedBox(height: 10),
                            Button(
                              width: double.infinity,
                              title: isLoading ? 'Saving...' : 'Save',
                              disable: !isLoading &&
                                      (((editableContactNumberTextField &&
                                                      _contactNumberController
                                                              .text !=
                                                          user[
                                                              'mobile_number']) ||
                                                  (editableNameTextField &&
                                                      _nameController.text !=
                                                          user['name'])) &&
                                              (_contactNumberInput.isNotEmpty ||
                                                  _nameInput.isNotEmpty) ||
                                          _pickedImage != null)
                                  ? false
                                  : true,
                              color: Colors.white,
                              backgroundColor: Config.primaryColor,
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
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

                                final nameVal = _nameController.text.isEmpty
                                    ? user['name']
                                    : _nameController.text;
                                final contactNumberVal =
                                    _contactNumberController.text.isEmpty
                                        ? user['mobile_number']
                                        : _contactNumberController.text;

                                authModel.updateUser({
                                  ...authModel.getUser,
                                  'name': nameVal,
                                  'mobile_number': contactNumberVal,
                                });
                                final token = await DioProvider()
                                    .updatePatientProfile(
                                        globalToken, nameVal, contactNumberVal);

                                snackBar(context, token['message'],
                                    Colors.green, Duration(seconds: 4));

                                await getData();
                                setState(() {
                                  _pickedImage = null;
                                  isLoading = false;
                                });
                              },
                              borderRadius: BorderRadius.circular(5),
                            ),
                            Button(
                              width: double.infinity,
                              title: 'Logout',
                              disable: false,
                              color: Colors.white,
                              backgroundColor: Colors.red.shade500,
                              onPressed: () async {
                                await showConfirmationDialog(context, 'Logout',
                                    () async {
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  final token = prefs.getString('token') ?? '';
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
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
