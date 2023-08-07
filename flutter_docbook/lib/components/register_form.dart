import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/button.dart';
import 'package:flutter_docbook/utils/config.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // TextFormField(
          //   controller: _emailController,
          //   keyboardType: TextInputType.emailAddress,
          //   cursorColor: Config.primaryColor,
          //   decoration: const InputDecoration(
          //     hintText: 'Email Address',
          //     labelText: 'Email',
          //     filled: true,
          //     fillColor: Color.fromRGBO(206, 222, 239, 1),
          //     alignLabelWithHint: true,
          //     prefixIcon: Icon(Icons.email_outlined),
          //     prefixIconColor: Config.primaryColor,
          //     enabledBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.all(Radius.circular(10)),
          //       borderSide: BorderSide(
          //         color: Colors.transparent,
          //       ),
          //     ),
          //   ),
          // ),
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
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _userNameController,
            cursorColor: Config.primaryColor,
            obscureText: obsecurePass,
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
          Button(
            width: double.infinity,
            title: 'Register',
            disable: false,
            color: Config.primaryColor,
            backgroundColor: Color.fromRGBO(239, 247, 255, 1),
            borderRadius: BorderRadius.circular(0),
            onPressed: () {
              Navigator.of(context).pushNamed('main');
            },
          )
        ],
      ),
    );
  }
}
