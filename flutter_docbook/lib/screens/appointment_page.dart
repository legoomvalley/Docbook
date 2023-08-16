import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_docbook/utils/config.dart';

import '../components/border_card.dart';
import '../components/button.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

enum FilterStatus {
  approved('approved'),
  rejected('rejected'),
  pending('pending');

  final String value;
  const FilterStatus(this.value);
}

class _AppointmentPageState extends State<AppointmentPage> {
  FilterStatus status = FilterStatus.approved;
  List<dynamic> schedules = [
    {
      "patient_name": "patient name 1",
      "date_&_time": "saturday and so on",
      "disease": "kencing maneh",
      "status": FilterStatus.approved.value,
    },
    {
      "patient_name": "patient name 2",
      "date_&_time": "saturday and so on",
      "disease": "kencing maneh",
      "status": FilterStatus.rejected.value,
    },
    {
      "patient_name": "patient name 3",
      "date_&_time": "saturday and so on",
      "disease": "kencing maneh",
      "status": FilterStatus.pending.value,
    },
    {
      "patient_name": "patient name 4",
      "date_&_time": "saturday and so on",
      "disease": "kencing maneh",
      "status": FilterStatus.pending.value,
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<dynamic> appointment =
        schedules.map((var schedule) => schedule).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.doctorTheme,
        automaticallyImplyLeading: false,
        title: Text('All Appointment'),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SearchPage(),
                    ),
                  ),
              icon: const Icon(
                Icons.search_sharp,
              )),
          PopupMenuButton(itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: 'all',
                child: Text('All Appointment'),
              ),
              PopupMenuItem(
                value: 'approved',
                child: Text('Approved Appointment'),
              ),
              PopupMenuItem(
                value: 'rejected',
                child: Text('Rejected Appointment'),
              ),
              PopupMenuItem(
                value: 'pending',
                child: Text('Pending Appointment'),
              ),
              PopupMenuItem(
                value: 'today',
                child: Text('Today Appointment'),
              ),
            ];
          })
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: Config.spaceSmall),
          SliverList.separated(
              itemCount: schedules.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 20);
              },
              itemBuilder: (context, index) {
                var _appointment = appointment[index];
                return SizedBox(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: BorderCard(
                      cardHeader: (_appointment['status'] != "pending")
                          ? Container(
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10)),
                                color: const Color.fromRGBO(94, 94, 184, 0.3),
                              ),
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              child: Container(
                                width: 30,
                                height: 30,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(0),
                                      backgroundColor: Colors.yellow[50],
                                      side: BorderSide(
                                          color: Colors.yellow.shade600,
                                          width: 2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      )),
                                  child: Icon(
                                    Icons.edit_calendar_sharp,
                                    size: 17,
                                    color: Colors.yellow[600],
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            )
                          : Container(),
                      topWidget: [
                        Expanded(
                          // width: double.infinity,
                          // color: Colors.red,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      color:
                                          (_appointment['status'] == "approved")
                                              ? Colors.green[100]
                                              : (_appointment['status'] ==
                                                      "rejected")
                                                  ? Colors.red[100]
                                                  : Colors.yellow[100],
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      _appointment['status'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: (_appointment['status'] ==
                                                "approved")
                                            ? Colors.green[600]
                                            : (_appointment['status'] ==
                                                    "rejected")
                                                ? Colors.red[600]
                                                : Colors.yellow[700],
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
                                _appointment['patient_name'],
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
                        (_appointment['status'] == "pending")
                            ? Button(
                                width: double.infinity,
                                title: 'Take action',
                                disable: false,
                                color: Colors.white,
                                backgroundColor:
                                    const Color.fromRGBO(253, 216, 53, 1),
                                onPressed: () {},
                                borderRadius: BorderRadius.circular(5),
                              )
                            : SizedBox()
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
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.doctorTheme,
        title: Container(
            width: double.infinity,
            decoration:
                BoxDecoration(border: Border.all(color: Colors.transparent)),
            child: Center(
                child: TextField(
              autofocus: true,
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: 'Search....',
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ))),
      ),
    );
  }
}

// all appointment doc can edit unless pending and today
// all,rejected(not approved), pending(doc don't give response yet), today(due date today and approved), approved
