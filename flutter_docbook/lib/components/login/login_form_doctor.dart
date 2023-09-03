import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/button.dart';
import 'package:flutter_docbook/components/snackBar.dart';
import 'package:flutter_docbook/providers/dio_provider.dart';
import 'package:flutter_docbook/utils/config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../models/auth_model.dart';

class LoginFormDoctor extends StatefulWidget {
  const LoginFormDoctor({super.key});

  @override
  State<LoginFormDoctor> createState() => _LoginFormDoctorState();
}

class _LoginFormDoctorState extends State<LoginFormDoctor> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool obsecurePass = true;
  String _emailErr = "";
  String _passwordErr = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
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
            ),
            validator: (value) {
              if (value == '') {
                return 'email field is required';
              } else {
                return null;
              }
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
              fillColor: Color.fromRGBO(94, 94, 184, 0.3),
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
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
            validator: (value) {
              if (value == '') {
                return "password field is required";
              } else {
                return null;
              }
            },
          ),
          Row(
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('register_doctor');
                },
                child: Text(
                  textAlign: TextAlign.left,
                  'Don\'t have an account?',
                  style: GoogleFonts.openSans(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
          // Config.spaceSmall,
          Consumer<AuthModel>(
            builder: (context, auth, child) {
              return Button(
                width: double.infinity,
                title: isLoading ? 'Please wait' : 'Sign In',
                disable: isLoading ? true : false,
                color: Config.doctorTheme,
                elevation: 5,
                backgroundColor: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(0),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  final token = await DioProvider()
                      .getTokenDoctor('london32@example.com', '123');
                  // if (_formKey.currentState!.validate()) {
                  if (token) {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    final tokenValue = prefs.getString('token') ?? '';
                    // auth.loginSuccess();
                    if (tokenValue.isNotEmpty && tokenValue != '') {
                      //get user data
                      final response =
                          await DioProvider().getUserDoctor(tokenValue);
                      if (response != null) {
                        setState(() {
                          final user = json.decode(response);

                          auth.loginSuccessDoctor(
                              user, tokenValue, user['doctor'][0]);
                          print(user['doctor'][0]);
                        });
                        MyApp.navigatorKey.currentState!
                            .pushNamed('main_doctor');
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  } else {
                    snackBar(context, 'Incorrect email or password',
                        Color.fromRGBO(244, 67, 54, 1), Duration(seconds: 4));
                  }
                  // }
                  // final token = await DioProvider().getTokenDoctor(
                  //     _emailController.text, _passwordController.text);
                  // if (_formKey.currentState!.validate()) {
                  //   print(token);
                  //   if (token) {
                  //     // auth.loginSuccess();
                  //     MyApp.navigatorKey.currentState!.pushNamed('main');
                  //   } else {
                  //     snackBar(context, 'Incorrect email or password',
                  //         Color.fromRGBO(244, 67, 54, 1), Duration(seconds: 4));
                  //   }
                  // }
                },
                // onPressed: () {
                //   Navigator.of(context).pushNamed('main_doctor');
                // },
              );
            },
          )
        ],
      ),
    );
  }
}
