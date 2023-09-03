// ignore_for_file: unused_import, prefer_const_constructors

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/button.dart';
import 'package:flutter_docbook/components/confirmation_dialog.dart';
import 'package:flutter_docbook/components/schedule_card.dart';
import 'package:flutter_docbook/models/datetime_converter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

import '../providers/dio_provider.dart';
import '../utils/config.dart';
import 'patient_update_appointment_page.dart';
import 'home_page.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

// enum for schedule status
// ignore: constant_identifier_names
// enum FilterStatus { pending, completed, not_approved, approved }
enum FilterStatus {
  pending('pending'),
  completed('completed'),
  notApproved('not approved'),
  approved('approved');

  final String value;
  const FilterStatus(this.value);
}

class _SchedulePageState extends State<SchedulePage> {
  // FilterStatus status = FilterStatus.pending; //initial status
  String status = "pending"; //initial status
  bool completed = false;
  bool approved = false;
  bool notApproved = false;
  List<dynamic> schedules = [];
  late String token; // Declare the token variable

  // get appointment details
  Future<void> getAppointments() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    final appointment = await DioProvider().getAppointments(token);
    if (appointment != 'Error') {
      final decodeData = json.decode(appointment);
      setState(() {
        schedules = decodeData;
      });
      print(schedules);
    }
  }

  @override
  void initState() {
    getAppointments();
    super.initState;
  }

  // int current = 0;

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    // double itemWidth = 150 / itemsCount;
    // ignore: unused_local_variable
    List<dynamic> filteredSchedules = schedules.where((var schedule) {
      switch (schedule['status']) {
        case 'pending':
          schedule['status'] = FilterStatus.pending.value;
          break;
        case 'completed':
          schedule['status'] = FilterStatus.completed.value;
          break;
        case 'approved':
          schedule['status'] = FilterStatus.approved.value;
          break;
        case 'not approved':
          schedule['status'] = FilterStatus.notApproved.value;
          break;
      }
      return schedule['status'] == status;
    }).toList();
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              height: 60,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        for (FilterStatus filterStatus in FilterStatus.values)
                          Container(
                            margin: EdgeInsets.all(5),
                            child: Material(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              color: filterStatus.value == status
                                  ? Colors.blue.shade50
                                  : Colors.grey.shade100,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(40),
                                onTap: () {
                                  setState(() {
                                    if (filterStatus == FilterStatus.pending) {
                                      status = FilterStatus.pending.value;
                                    } else if (filterStatus ==
                                        FilterStatus.completed) {
                                      status = FilterStatus.completed.value;
                                    } else if (filterStatus ==
                                        FilterStatus.approved) {
                                      status = FilterStatus.approved.value;
                                    } else if (filterStatus ==
                                        FilterStatus.notApproved) {
                                      status = FilterStatus.notApproved.value;
                                    }
                                  });
                                },
                                child: Ink(
                                  child: AnimatedContainer(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    duration: const Duration(milliseconds: 100),
                                    height: 60,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    width: 150,
                                    child: Center(
                                      child: Text(
                                        filterStatus.value,
                                        style: TextStyle(
                                          color: filterStatus.value == status
                                              ? Config.primaryColor
                                              : Color.fromRGBO(
                                                  134, 150, 187, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  }),
            ),
          ),
          SliverToBoxAdapter(child: Config.spaceSmall),
          filteredSchedules.isEmpty
              ? SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(top: 200),
                    child: Text(
                      'no record',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      var schedule = filteredSchedules[index];
                      schedule['status'] == FilterStatus.completed.value
                          ? completed = true
                          : completed = false;
                      schedule['status'] == FilterStatus.approved.value
                          ? approved = true
                          : approved = false;
                      schedule['status'] == FilterStatus.notApproved.value
                          ? notApproved = true
                          : notApproved = false;

                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Material(
                          shadowColor: Colors.black38,
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            AssetImage('assets/user.jpg'),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Config.spaceSmall,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            schedule['doctor_name'],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            schedule['specialization_name'],
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w100,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  // Schedule Card
                                  ScheduleCard(
                                    date: schedule['date'],
                                    day: DateConverter.getDayOfWeek(
                                        DateTime.parse(schedule['date'])),
                                    time: schedule['time'],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        notApproved
                                            ? Container()
                                            : Expanded(
                                                child: OutlinedButton(
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.blue
                                                                    .shade50),
                                                    onPressed: () async {
                                                      await showConfirmationDialog(
                                                          context,
                                                          'Do you want to cancel this appointment',
                                                          () async {
                                                        final response =
                                                            await DioProvider()
                                                                .deletePatientAppointment(
                                                                    schedule[
                                                                        'id'],
                                                                    token);
                                                        if (response) {
                                                          setState(() {
                                                            schedules.remove(
                                                                schedule);
                                                          });
                                                        }
                                                      });
                                                    },
                                                    child: Text(
                                                      completed
                                                          ? 'remove'
                                                          : 'Cancel',
                                                      style: TextStyle(
                                                          color: Config
                                                              .primaryColor),
                                                    )),
                                              ),
                                        notApproved
                                            ? Container()
                                            : const SizedBox(
                                                width: 20,
                                              ),
                                        Expanded(
                                          child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                backgroundColor:
                                                    Config.primaryColor,
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PatientUpdateAppointment(
                                                            scheduleData:
                                                                schedule),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                completed ||
                                                        approved ||
                                                        notApproved
                                                    ? 'details'
                                                    : 'Reschedule',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ])
                                ]),
                          ),
                        ),
                      );
                    },
                    childCount: filteredSchedules.length,
                  ),
                )
        ]),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard(
      {Key? key, required this.date, required this.day, required this.time})
      : super(key: key);
  final String date;
  final String day;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Divider(color: Colors.black26),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.black54,
                  size: 15,
                ),
                SizedBox(width: 5),
                Text(
                  '$day, $date',
                  style: const TextStyle(color: Colors.black54),
                ),
              ]),
              Row(children: [
                Icon(
                  Icons.watch_later_outlined,
                  color: Colors.black54,
                  size: 17,
                ),
                SizedBox(width: 5),
                Text(
                  '$time',
                  style: TextStyle(color: Colors.black54),
                ),
              ])
            ],
          ),
        ],
      ),
    );
  }
}
