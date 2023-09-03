import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_docbook/screens/appointment_details.dart';
import 'package:flutter_docbook/screens/doctor/search_page.dart';
import 'package:flutter_docbook/utils/config.dart';
import 'package:provider/provider.dart';

import '../components/border_card.dart';
import '../components/button.dart';
import '../components/confirmation_dialog.dart';
import '../models/auth_model.dart';
import '../models/datetime_converter.dart';
import '../providers/dio_provider.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

enum FilterStatus {
  all('All'),
  approved('Approved'),
  rejected('Rejected'),
  pending('Pending'),
  today('Today'),
  completed('Completed');

  final String value;
  const FilterStatus(this.value);
}

class _AppointmentPageState extends State<AppointmentPage> {
  DateTime dateTIme = DateTime(2022, 12, 24);
  Map<String, dynamic> user = {};
  List<dynamic> appointments = [];
  List<dynamic> searchAppointments = [];
  List<dynamic> todayAppointments = [];
  // String appBarTitle = 'All Appointemnt';

  FilterStatus selectedStatus = FilterStatus.all;
  String appBarTitle = FilterStatus.all.value;
  String token = '';

  Future<void> getData() async {
    setState(() {
      user = Provider.of<AuthModel>(context, listen: false).getUser;
      token = Provider.of<AuthModel>(context, listen: false).getToken;
      appointments = user['patient'];
      searchAppointments = user['patient'];
      todayAppointments = user['today_app'];
      switch (selectedStatus) {
        case FilterStatus.approved:
          appointments = appointments
              .where((appointment) => appointment['status'] == 'approved')
              .toList();
          break;
        case FilterStatus.rejected:
          appointments = appointments
              .where((appointment) => appointment['status'] == 'not approved')
              .toList();
          break;
        case FilterStatus.pending:
          appointments = appointments
              .where((appointment) => appointment['status'] == 'pending')
              .toList();
          break;
        case FilterStatus.today:
          appointments = todayAppointments;
          break;
        case FilterStatus.completed:
          appointments = appointments
              .where((appointment) => appointment['status'] == 'completed')
              .toList();
          break;
        case FilterStatus.all:
        default:
          // No need to filter for "All" status
          break;
      }
      appBarTitle = selectedStatus.value;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.doctorTheme,
        automaticallyImplyLeading: false,
        title: Text("$appBarTitle appointment"),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SearchPage(
                          appointments: searchAppointments, token: token),
                    ),
                  ),
              icon: const Icon(
                Icons.search_sharp,
              )),
          PopupMenuButton<FilterStatus>(
            onSelected: (FilterStatus result) {
              setState(() {
                selectedStatus = result;
                getData(); // Call getData again to apply the filter
              });
            },
            itemBuilder: (BuildContext context) {
              return FilterStatus.values.map((FilterStatus filterStatus) {
                return PopupMenuItem<FilterStatus>(
                  value: filterStatus,
                  child: Text(filterStatus.value),
                );
              }).toList();
            },
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: Config.spaceSmall),
          appointments.length == 0
              ? SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(top: 180),
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
                  itemCount: appointments.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 20);
                  },
                  itemBuilder: (context, index) {
                    var _appointment = appointments[index];
                    var _convertedDate = DateConverter.formatDate2(
                        _appointment['date'].toString());

                    return SizedBox(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: BorderCard(
                          cardHeader: _appointment['status'] != "pending"
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10)),
                                    color:
                                        const Color.fromRGBO(94, 94, 184, 0.3),
                                  ),
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 30,
                                        height: 30,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.all(0),
                                              backgroundColor:
                                                  Colors.yellow[50],
                                              side: BorderSide(
                                                  color: Colors.red.shade600,
                                                  width: 2),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                              )),
                                          child: Icon(
                                            Icons.delete_forever_outlined,
                                            size: 17,
                                            color: Colors.red[600],
                                          ),
                                          onPressed: () async {
                                            print(_appointment);
                                            await showConfirmationDialog(
                                                context,
                                                'are you sure to remove this appointment',
                                                () async {
                                              final response =
                                                  await DioProvider()
                                                      .deleteDoctorAppointment(
                                                          _appointment['id'],
                                                          token);
                                              print(response);
                                              if (response) {
                                                setState(() {
                                                  appointments
                                                      .remove(_appointment);
                                                });
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                          width: _appointment['status'] ==
                                                  "completed"
                                              ? 0
                                              : 10),
                                      _appointment['status'] == "completed"
                                          ? SizedBox()
                                          : Container(
                                              width: 30,
                                              height: 30,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    padding: EdgeInsets.all(0),
                                                    backgroundColor:
                                                        Colors.yellow[50],
                                                    side: BorderSide(
                                                        color: Colors
                                                            .yellow.shade600,
                                                        width: 2),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                    )),
                                                child: Icon(
                                                  Icons.edit_calendar_sharp,
                                                  size: 17,
                                                  color: Colors.yellow[600],
                                                ),
                                                onPressed: () async {
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AppointmentDetails(
                                                              appointment:
                                                                  _appointment,
                                                              token: token,
                                                              index: index),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                    ],
                                  ),
                                )
                              : Container(),
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
                                          color: (_appointment['status'] ==
                                                      "approved" ||
                                                  _appointment['status'] ==
                                                      "completed")
                                              ? Colors.green[100]
                                              : _appointment['status'] ==
                                                      "not approved"
                                                  ? Colors.red[100]
                                                  : Colors.yellow[100],
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          _appointment['status'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: (_appointment['status'] ==
                                                        "approved" ||
                                                    _appointment['status'] ==
                                                        "completed")
                                                ? Colors.green[600]
                                                : _appointment['status'] ==
                                                        "not approved"
                                                    ? Colors.red[600]
                                                    : Colors.yellow[700],
                                            fontSize: 12,
                                          ),
                                        ),
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
                                        "$_convertedDate At ${_appointment['time']}",
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
                                        _appointment['disease'],
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
                            _appointment['status'] == "pending" ||
                                    _appointment['status'] == "completed"
                                ? Button(
                                    width: double.infinity,
                                    title: _appointment['status'] == "pending"
                                        ? 'Take action'
                                        : 'Details',
                                    disable: false,
                                    color: Colors.white,
                                    backgroundColor: _appointment['status'] ==
                                            "pending"
                                        ? const Color.fromRGBO(253, 216, 53, 1)
                                        : Colors.greenAccent,
                                    onPressed: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AppointmentDetails(
                                                  appointment: _appointment,
                                                  token: token,
                                                  index: index),
                                        ),
                                      );
                                    },
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


// all appointment doc can edit unless pending and today
// all,rejected(not approved), pending(doc don't give response yet), today(due date today and approved), approved
