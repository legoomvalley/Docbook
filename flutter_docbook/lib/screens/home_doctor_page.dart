// ignore_for_file: sort_child_properties_last, unnecessary_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/border_card.dart';
import 'package:flutter_docbook/components/button.dart';
import 'package:flutter_docbook/utils/config.dart';
import 'package:google_fonts/google_fonts.dart';

import 'appointment_page.dart';

class HomeDoctorPage extends StatefulWidget {
  const HomeDoctorPage({super.key});

  @override
  State<HomeDoctorPage> createState() => _HomeDoctorPageState();
}

class _HomeDoctorPageState extends State<HomeDoctorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Config.spaceSmall,
                    Text(
                      'Hello, doctor',
                      style: GoogleFonts.rubik(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      textAlign: TextAlign.center,
                      'Welcome back!',
                      style: GoogleFonts.rubik(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                    Config.spaceSmall,
                    Row(
                      children: [
                        Expanded(
                          child: BorderCard(
                            cardHeader: Container(),
                            topWidget: [
                              Text(
                                '100',
                                style: TextStyle(
                                  color: Config.doctorTheme,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(94, 94, 184, 0.2),
                                ),
                                child: Icon(
                                  Icons.calendar_today_outlined,
                                  color: Config.doctorTheme,
                                  size: 18,
                                ),
                                alignment: Alignment.center,
                              ),
                            ],
                            btmWidget: [
                              SizedBox(height: 15),
                              Text(
                                'Total Appointment',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: BorderCard(
                            cardHeader: Container(),
                            topWidget: [
                              Text(
                                '100',
                                style: TextStyle(
                                  color: Config.doctorTheme,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(94, 94, 184, 0.2),
                                ),
                                child: Icon(
                                  Icons.today_outlined,
                                  color: Config.doctorTheme,
                                  size: 18,
                                ),
                                alignment: Alignment.center,
                              ),
                            ],
                            btmWidget: [
                              SizedBox(height: 15),
                              Text(
                                'Today Appointment',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: BorderCard(
                            cardHeader: Container(),
                            topWidget: [
                              Text(
                                '100',
                                style: TextStyle(
                                  color: Config.doctorTheme,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(94, 94, 184, 0.2),
                                ),
                                child: Icon(
                                  Icons.pending_actions_outlined,
                                  color: Config.doctorTheme,
                                  size: 18,
                                ),
                                alignment: Alignment.center,
                              ),
                            ],
                            btmWidget: [
                              SizedBox(height: 15),
                              Text(
                                'Pending Appointment',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: BorderCard(
                            cardHeader: Container(),
                            topWidget: [
                              Text(
                                '100',
                                style: TextStyle(
                                  color: Config.doctorTheme,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(94, 94, 184, 0.2),
                                ),
                                child: Icon(
                                  Icons.cancel_presentation,
                                  color: Config.doctorTheme,
                                  size: 18,
                                ),
                                alignment: Alignment.center,
                              ),
                            ],
                            btmWidget: [
                              SizedBox(height: 15),
                              Text(
                                'Rejected Appointment',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Config.spaceSmall,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Today Appointment',
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SliverList.separated(
              itemCount: 5,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 20);
              },
              itemBuilder: (context, index) => SizedBox(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: BorderCard(
                    cardHeader: Container(),
                    topWidget: [
                      Expanded(
                        // width: double.infinity,
                        // color: Colors.red,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Patient Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontSize: 15,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    'Approved',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                  // child: Text(
                                  //   'Pending',
                                  //   style: TextStyle(
                                  //     fontWeight: FontWeight.bold,
                                  //     color: Colors.yellow[600],
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                )
                              ],
                            ),
                            Text(
                              'Ahmad Muaz Aiman Bin Ahmad Badri',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    btmWidget: [
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Date & Time',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  '20 Sep, 2022 At 03:11 PM',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Disease',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Kencing maneh',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      // Button(
                      //   width: double.infinity,
                      //   title: 'Take action',
                      //   disable: false,
                      //   color: Colors.white,
                      //   backgroundColor: const Color.fromRGBO(253, 216, 53, 1),
                      //   onPressed: () {},
                      //   borderRadius: BorderRadius.circular(5),
                      // )
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
          ],
        ),
      ),
    );
  }
}
