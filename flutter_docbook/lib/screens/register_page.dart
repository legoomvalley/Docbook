import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_docbook/utils/config.dart';

import '../components/login_form_patient.dart';
import '../components/register_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Config.spaceSmall,
              Container(
                width: double.infinity,
                padding:
                    EdgeInsets.only(top: 10, bottom: 100, left: 20, right: 20),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      child: Text(
                        textAlign: TextAlign.left,
                        'Register as patient',
                        style: GoogleFonts.openSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Config.spaceSmall,
                    RegisterFormPatient(),
                    Container(
                      child: TextButton(
                        onPressed: () {},
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// islogin boolean,
// list view
// item builder
// stream builder fetch data real time, continously upload data
// future builder for one time upload data
// connection state for
// snapshot handle data from backend
// cardview
