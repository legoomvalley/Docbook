import 'package:flutter/material.dart';
import 'package:flutter_docbook/main_layout.dart';
import 'package:flutter_docbook/screens/auth_page.dart';
import 'package:flutter_docbook/screens/doctor_details_page.dart';
import 'package:flutter_docbook/screens/doctor_specific_appointment_page.dart';
import 'package:flutter_docbook/screens/home_page.dart';
import 'package:flutter_docbook/screens/review_page.dart';
import 'package:flutter_docbook/screens/success_appointment_page.dart';
import 'package:flutter_docbook/utils/config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // push navigator
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // pre-define input decoration
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
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Config.primaryColor,
          selectedItemColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey.shade500,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthPage(),
        'main': (context) => const MainLayout(),
        'doc_specific_appointment': (context) =>
            const DoctorSpecificAppointment(),
        'success_appointment': (context) => const SuccessAppointment(),
        'doctor_details': (context) => const DoctorDetails(),
        'review_list': (context) => ReviewListPage(),
      },
    );
  }
}
