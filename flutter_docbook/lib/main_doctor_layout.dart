import 'package:flutter/material.dart';
import 'package:flutter_docbook/screens/appointment_page.dart';
import 'package:flutter_docbook/screens/home_doctor_page.dart';
import 'package:flutter_docbook/utils/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainDoctorLayout extends StatefulWidget {
  const MainDoctorLayout({super.key});

  @override
  State<MainDoctorLayout> createState() => _MainDoctorLayoutState();
}

class _MainDoctorLayoutState extends State<MainDoctorLayout> {
  // variable declaration
  int currentPage = 0;
  final PageController _page = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _page,
        onPageChanged: ((value) {
          setState(() {
            currentPage = value;
          });
        }),
        children: const <Widget>[
          HomeDoctorPage(),
          AppointmentPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Config.doctorTheme,
        currentIndex: currentPage,
        onTap: (page) {
          setState(() {
            currentPage = page;
            _page.animateToPage(
              page,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.houseChimneyMedical),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.meeting_room),
            label: 'Appointment',
          ),
        ],
      ),
    );
  }
}
