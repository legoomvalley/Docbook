// ignore_for_file: sort_child_properties_last, unnecessary_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/border_card.dart';
import 'package:flutter_docbook/components/button.dart';
import 'package:flutter_docbook/utils/config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/auth_model.dart';
import '../models/datetime_converter.dart';
import 'appointment_page.dart';

class HomeDoctorPage extends StatefulWidget {
  const HomeDoctorPage({super.key});

  @override
  State<HomeDoctorPage> createState() => _HomeDoctorPageState();
}

class _HomeDoctorPageState extends State<HomeDoctorPage> {
  Map<String, dynamic> user = {};
  List<dynamic> appointments = [];
  List<dynamic> todayAppointments = [];
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    user = Provider.of<AuthModel>(context, listen: false).getUser;
    appointments = user['patient'];
    todayAppointments = appointments[0]['today_app'];

    print(appointments);

    List<dynamic> filterAppointmentsByStatus(String status) {
      return appointments
          .where((appointment) => appointment['status'] == status)
          .toList();
    }

    List<dynamic> pendingAppointments = filterAppointmentsByStatus('pending');
    List<dynamic> rejectedAppointments =
        filterAppointmentsByStatus('not approved');

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
                      'Hello, ${user['name']}',
                      style: GoogleFonts.rubik(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      textAlign: TextAlign.center,
                      'Welcome!',
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
                                '${appointments.length}',
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
                                '${todayAppointments.length}',
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
                                '${pendingAppointments.length}',
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
                                '${rejectedAppointments.length}',
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
            todayAppointments.length == 0
                ? SliverToBoxAdapter(
                    child: Container(
                      height: 140,
                      width: double.infinity,
                      child: Stack(alignment: Alignment.center, children: [
                        Container(
                          height: 130,
                          width: 150,
                          child: Image.asset(
                            'assets/no_appointment.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          child: Text(
                            'No Appointments Available',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ]),
                    ),
                  )
                : SliverList.separated(
                    itemCount: todayAppointments.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 20);
                    },
                    itemBuilder: (context, index) {
                      var today_appointment = todayAppointments[index];
                      return SizedBox(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: BorderCard(
                            cardHeader: Container(),
                            topWidget: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            borderRadius:
                                                BorderRadius.circular(7),
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
                                      today_appointment['full_name'],
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Date & time',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          '${DateConverter().formatDate2(today_appointment['date'])} at ${today_appointment['time']}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                          today_appointment['disease'],
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
                            ],
                          ),
                        ),
                      );
                    }),
            SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
          ],
        ),
      ),
    );
  }
}
