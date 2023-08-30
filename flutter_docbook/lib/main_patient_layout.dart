import 'package:flutter/material.dart';
import 'package:flutter_docbook/screens/doctor_list_page.dart';
import 'package:flutter_docbook/screens/home_page.dart';
import 'package:flutter_docbook/screens/profile_page.dart';
import 'package:flutter_docbook/screens/schedule_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'components/filter_specialization.dart';

class MainPatientLayout extends StatefulWidget {
  const MainPatientLayout({super.key});
  @override
  State<MainPatientLayout> createState() => _MainPatientLayoutState();
}

class _MainPatientLayoutState extends State<MainPatientLayout> {
  // variable declaration
  int currentPage = 0;
  final PageController _page = PageController();
  String selectedSpecialization = ''; // Default value
// Store the selected specialization

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
          children: <Widget>[
            HomePage(
              onSpecializationSelected: (specialization) {
                selectedSpecialization = specialization;
                setState(() {
                  selectedSpecialization = specialization;
                  _page.jumpToPage(1);
                });
              },
            ),
            DoctorListPageWrapper(specialization: selectedSpecialization),
            SchedulePage(),
            ProfilePage(),
          ]),
      bottomNavigationBar: BottomNavigationBar(
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
            icon: FaIcon(FontAwesomeIcons.userDoctor),
            label: 'Doctor List',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.clipboard),
            label: 'Record',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class DoctorListPageWrapper extends StatelessWidget {
  final String specialization;

  DoctorListPageWrapper({required this.specialization});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoctorListPage(specialization: specialization),
    );
  }
}
