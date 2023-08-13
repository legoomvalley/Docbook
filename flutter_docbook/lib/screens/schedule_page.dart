// ignore_for_file: unused_import, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/button.dart';
import 'package:flutter_docbook/components/schedule_card.dart';
import 'dart:developer';

import '../utils/config.dart';
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

class ScheduleTitle {
  final String title;

  const ScheduleTitle({
    required this.title,
  });
}

class CardItem {
  final String urlImg;
  final String title;
  final String specialist;

  const CardItem({
    required this.urlImg,
    required this.title,
    required this.specialist,
  });
}

class _SchedulePageState extends State<SchedulePage> {
  FilterStatus status = FilterStatus.pending; //initial status
  List<dynamic> schedules = [
    {
      "doctor_name": "doctor name 1",
      "doctor_profile": "assets/doctor.jpg",
      "category": 'category 1',
      "status": FilterStatus.pending.value
    },
    {
      "doctor_name": "doctor name 2",
      "doctor_profile": "assets/doctor.jpg",
      "category": 'category 2',
      "status": FilterStatus.completed.value
    },
    {
      "doctor_name": "doctor name 3",
      "doctor_profile": "assets/doctor.jpg",
      "category": 'category 3',
      "status": FilterStatus.completed.value
    },
    {
      "doctor_name": "doctor name 4",
      "doctor_profile": "assets/doctor.jpg",
      "category": 'category 4',
      "status": FilterStatus.notApproved.value
    },
    {
      "doctor_name": "doctor name 5",
      "doctor_profile": "assets/doctor.jpg",
      "category": 'category 1',
      "status": FilterStatus.pending.value
    },
    {
      "doctor_name": "doctor name 6",
      "doctor_profile": "assets/doctor.jpg",
      "category": 'category 2',
      "status": FilterStatus.completed.value
    },
    {
      "doctor_name": "doctor name 7",
      "doctor_profile": "assets/doctor.jpg",
      "category": 'category 3',
      "status": FilterStatus.notApproved.value
    },
    {
      "doctor_name": "doctor name 8",
      "doctor_profile": "assets/doctor.jpg",
      "category": 'category 4',
      "status": FilterStatus.completed.value
    },
  ];

  List<ScheduleTitle> scheduleTitle = [
    ScheduleTitle(
      title: "All appointment",
    ),
    ScheduleTitle(
      title: "Approved",
    ),
    ScheduleTitle(
      title: "Completed",
    ),
    ScheduleTitle(
      title: "Rejected",
    ),
    ScheduleTitle(
      title: "Pending",
    ),
  ];
  List<CardItem> doctorCardLists = [
    CardItem(
      urlImg: 'assets/doctor.jpg',
      title: "doctor 1",
      specialist: "specialist",
    ),
    CardItem(
      urlImg: 'assets/doctor.jpg',
      title: "doctor 2",
      specialist: "specialist",
    ),
    CardItem(
      urlImg: 'assets/doctor.jpg',
      title: "doctor 3",
      specialist: "specialist",
    ),
    CardItem(
      urlImg: 'assets/doctor.jpg',
      title: "doctor 4",
      specialist: "specialist",
    ),
  ];
  int current = 0;

  @override
  Widget build(BuildContext context) {
    // double itemWidth = 150 / itemsCount;
    // ignore: unused_local_variable
    List<dynamic> filteredSchedules = schedules.where((var schedule) {
      return schedule['status'] == status.value;
    }).toList();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30),
                height: 60,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: scheduleTitle.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          // for (FilterStatus filterStatus in FilterStatus.values)
                          Container(
                            margin: EdgeInsets.all(5),
                            child: Material(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              color: current == index
                                  ? Colors.blue.shade50
                                  : Colors.grey.shade100,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(40),
                                onTap: () {
                                  setState(() {
                                    current = index;
                                  });
                                  print(current);
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
                                        scheduleTitle[index].title,
                                        style: TextStyle(
                                          color: current == index
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

                          // AnimatedPositioned(
                          //   // right: 10,
                          //   left: 165 * selectedItemIndex,
                          //   duration: const Duration(milliseconds: 200),
                          //   //             curve: Curves.easeInOut,
                          //   // ignore: sized_box_for_whitespace
                          //   child: Container(
                          //     height: 60,
                          //     child: Button(
                          //       margin: EdgeInsets.only(bottom: 10),
                          //       width: 150,
                          //       title: status.name,
                          //       disable: false,
                          //       color: Colors.black,
                          //       backgroundColor: Colors.blue,
                          //       onPressed: () {},
                          //       borderRadius: BorderRadius.circular(40),
                          //     ),
                          //   ),
                          // ),
                        ],
                      );
                    }),
              ),

              SizedBox(height: 20),
              Container(
                height: 1000,
                child: ListView.builder(
                  itemCount: filteredSchedules.length,
                  itemBuilder: ((context, index) {
                    var _schedule = filteredSchedules[index];
                    bool isLastElement = filteredSchedules.length + 1 == index;
                    return Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: !isLastElement
                          ? const EdgeInsets.only(bottom: 20)
                          : EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage(_schedule['doctor_profile']),
                              ),
                              Config.spaceSmall,
                              Text(
                                _schedule['doctor_name'],
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                    // Container(
                    //   margin: EdgeInsets.only(left: 20, right: 20),
                    //   child: Column(
                    //     children: List.generate(10, (index) {
                    //       return ScheduleCard();
                    //     }),
                    //   ),
                    // );
                  }),
                ),
              ),

              // Container(
              //   margin: EdgeInsets.only(left: 20, right: 20),
              //   child: Column(
              //     children: List.generate(10, (index) {
              //       return ScheduleCard();
              //     }),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget doctorHomeListCard({required CardItem doctorCardList}) => Container(
      padding: EdgeInsets.only(left: 19, bottom: 25),
      child: SizedBox(
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 4 / 4,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10.0)),
                    child: Image.asset(
                      doctorCardList.urlImg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // const SizedBox(height: 4),
              SizedBox(height: 8),
              Text(doctorCardList.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 5),
              Text(
                doctorCardList.specialist,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
