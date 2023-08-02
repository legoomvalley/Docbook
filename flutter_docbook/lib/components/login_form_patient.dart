import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/button.dart';
import 'package:flutter_docbook/utils/config.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginFormPatient extends StatefulWidget {
  const LoginFormPatient({super.key});

  @override
  State<LoginFormPatient> createState() => _LoginFormPatientState();
}

class _LoginFormPatientState extends State<LoginFormPatient> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool obsecurePass = true;

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
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Email Address',
              labelText: 'Email',
              filled: true,
              fillColor: Color.fromRGBO(206, 222, 239, 1),
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.email_outlined),
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
                onPressed: () {},
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
              TextButton(
                onPressed: () {},
                child: Text(
                  textAlign: TextAlign.left,
                  'Forgot Password?',
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
            title: 'Sign In',
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
