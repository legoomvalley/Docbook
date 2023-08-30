// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_docbook/main_patient_layout.dart';
import 'package:flutter_docbook/screens/search_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_docbook/utils/config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/doctor_home_list_card.dart';
import '../components/filter_specialization.dart';
import '../models/auth_model.dart';
import '../providers/dio_provider.dart';
import 'doctor_list_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.onSpecializationSelected});
  final Function(String) onSpecializationSelected;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // this controller will store the value of the search bar
  final TextEditingController _searchController = TextEditingController();
  Map<String, dynamic> user = {};
  Map<String, dynamic> doctors = {};

  List<dynamic> specializationItems = [
    {
      "name": "Pediatrics",
      "icon": FaIcon(FontAwesomeIcons.baby),
    },
    {
      "name": "General Medicine",
      "icon": FaIcon(FontAwesomeIcons.stethoscope),
    },
    {
      "name": "Orthopedics",
      "icon": FaIcon(FontAwesomeIcons.bone),
    },
    {
      "name": "Eye Specialist",
      "icon": FaIcon(FontAwesomeIcons.eye),
    },
  ];

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    user = Provider.of<AuthModel>(context, listen: false).getUser;

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
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Container(
                        // color: Config.primaryColor,
                        height: 150.0,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Config.primaryColor,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10),
                            bottom: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(top: 40)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hi ${user['name']}",
                                      style: GoogleFonts.openSans(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w200,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      textAlign: TextAlign.center,
                                      'Find Your Doctor',
                                      style: GoogleFonts.openSans(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        user['profile_photo_path'] != null
                                            ? Image.network(
                                                'http://10.0.2.2:8000/storage/${user['profile_photo_path']}',
                                              ).image
                                            : Image.asset('assets/user.jpg')
                                                .image,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 120),
                        width: double.infinity,
                        // color: Colors.black12,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Material(
                          elevation: 20.0,
                          borderRadius: BorderRadius.circular(7.0),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search Doctor...',
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              suffixIcon: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Search(
                                              initialQuery:
                                                  _searchController.text),
                                        ));
                                  }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 40),
                          child: Text(
                            'Doctor\'s specialization',
                            style: GoogleFonts.openSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          height: 102,
                          width: double.infinity,
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: specializationItems.length,
                            itemBuilder: (context, int index) {
                              return Column(children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Material(
                                    color: Colors.grey.shade100,
                                    child: InkWell(
                                      onTap: () {
                                        widget.onSpecializationSelected(
                                            specializationItems[index]['name']);
                                      },
                                      child: Container(
                                        width: 70,
                                        height: 70,
                                        child: Center(
                                          child: IconTheme(
                                            data: IconThemeData(
                                                color: Config.primaryColor),
                                            child: specializationItems[index]
                                                ['icon'],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  specializationItems[index]['name'],
                                  style: GoogleFonts.openSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(123, 137, 171, 1)
                                      // color: Colors.white,
                                      ),
                                ),
                              ]);
                            },
                            separatorBuilder: (BuildContext context, index) =>
                                Container(width: (index == 2) ? 22 : 10),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 40, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Doctors',
                                style: GoogleFonts.openSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Material(
                                child: InkWell(
                                  onTap: () {
                                    widget.onSpecializationSelected('All');
                                  },
                                  child: Text(
                                    'see all',
                                    style: GoogleFonts.rubik(
                                      textStyle: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 250,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var doctor = user['doctor'][index];
                              return DoctorHomeListCard(
                                route: 'doctor_details',
                                doctor: doctor,
                                isLastCard: index == 4 - 1,
                              );
                            },
                            itemCount: 4,
                          ),
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

// islogin boolean,
// list view
// item builder
// stream builder fetch data real time, continously upload data
// future builder for one time upload data
// connection state for
// snapshot handle data from backend
// cardview
