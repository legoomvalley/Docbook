import 'package:flutter/material.dart';
import 'package:flutter_docbook/main_patient_layout.dart';
import 'package:flutter_docbook/screens/appointment_page.dart';
import 'package:flutter_docbook/screens/auth_doctor_page.dart';
import 'package:flutter_docbook/screens/auth_patient_page.dart';
import 'package:flutter_docbook/screens/doctor_details_page.dart';
import 'package:flutter_docbook/screens/doctor_list_page.dart';
import 'package:flutter_docbook/screens/patient_make_appointment_page.dart';
import 'package:flutter_docbook/screens/patient_update_appointment_page.dart';
import 'package:flutter_docbook/screens/register_doctor_page.dart';
import 'package:flutter_docbook/screens/register_patient_page.dart';
import 'package:flutter_docbook/screens/review_page.dart';
import 'package:flutter_docbook/screens/appointment_msg_page.dart';
import 'package:flutter_docbook/utils/config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'main_doctor_layout.dart';
import 'models/auth_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // push navigator
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthModel>(
      create: (context) => AuthModel(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // pre-define input decoration
          fontFamily: GoogleFonts.rubik().fontFamily,
          inputDecorationTheme: const InputDecorationTheme(
            focusColor: Config.primaryColor,
            border: Config.outlinedBorder,
            focusedBorder: Config.focusBorder,
            errorBorder: Config.errorBorder,
            enabledBorder: Config.outlinedBorder,
            floatingLabelStyle: TextStyle(color: Config.primaryColor),
            prefixIconColor: Colors.black38,
          ),
          scaffoldBackgroundColor: Colors.white,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Config.primaryColor,
            selectedItemColor: Colors.white,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            unselectedItemColor: Colors.white,
            elevation: 10,
            type: BottomNavigationBarType.fixed,
          ),
        ),
        initialRoute: '/',
        routes: {
          // patient
          '/': (context) => const AuthPage(),
          'register': (context) => const RegisterPage(),
          'main_patient': (context) => const MainPatientLayout(),
          'patient_update_appointment_page': (context) =>
              const PatientUpdateAppointment(),
          'patient_make_appointment_page': (context) =>
              const PatientMakeAppointment(),
          'appointment_msg': (context) => const AppointmentMsg(),
          'doctor_details': (context) => DoctorDetails(),
          'review_list': (context) => const ReviewListPage(),

          // doctor
          'main_doctor': (context) => const MainDoctorLayout(),
          'doctor_list': (context) => const DoctorListPage(),
          'register_doctor': (context) => const RegisterDoctorPage(),
          'auth_doctor': (context) => const AuthDoctorPage(),
          'appointment_list': (context) => const AppointmentPage(),
        },
      ),
    );
  }
}
