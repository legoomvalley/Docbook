// ignore_for_file: prefer_const_literals_to_create_immutables, duplicate_ignore, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/profile_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/config.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // ignore: unused_field
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  // color: Config.primaryColor,
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
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('assets/user.jpg'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 40, right: 20),
              width: double.infinity,
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
                  Column(
                    children: List.generate(4, (index) {
                      return ProfileCard();
                    }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
