// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../components/button.dart';
import '../components/custom_appbar.dart';
import '../utils/config.dart';

class DoctorSpecificAppointment extends StatefulWidget {
  const DoctorSpecificAppointment({Key? key}) : super(key: key);

  @override
  State<DoctorSpecificAppointment> createState() =>
      _DoctorSpecificAppointmentState();
}

class _DoctorSpecificAppointmentState extends State<DoctorSpecificAppointment> {
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  String? token; //get token for insert booking date and time into database

  Future<void> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    // final doctor = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      // ignore: prefer_const_constructors
      appBar: CustomAppBar(
        appTitle: 'Appointment',
        icon: const FaIcon(Icons.arrow_back_ios),
      ),
      body: Container(
        // ignore: prefer_const_constructors
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  // ignore: avoid_unnecessary_containers
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 4,
                      child: Container(
                        width: double.infinity,
                        child: Row(children: [
                          Container(
                            width: 110,
                            height: 110,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FittedBox(
                                // ignore: sort_child_properties_last
                                child: Image(
                                  image: AssetImage('assets/user.jpg'),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dr Username',
                                  style: GoogleFonts.rubik(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Dr Username',
                                  style: GoogleFonts.rubik(
                                    textStyle: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(103, 114, 148, 1),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 36),
                                Text(
                                  'Dr Specialist',
                                  style: GoogleFonts.rubik(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Config.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    child: _tableCalendar(),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 62, vertical: 12),
                    width: double.infinity,
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(
                              0, -3), // Negative y offset for the top shadow
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45),
                          topRight: Radius.circular(45)),
                    ),
                    child: CustomScrollView(slivers: [
                      _isWeekend
                          ? SliverToBoxAdapter(
                              child: Container(
                                alignment: Alignment.center,
                                child: const Text(
                                  "Weekend is not available, please select another date",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                          : SliverGrid(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return Container(
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        setState(() {
                                          // when selected, update current index and set time selected to true
                                          _currentIndex = index;
                                          _timeSelected = true;
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        decoration: BoxDecoration(
                                            color: _currentIndex == index
                                                ? const Color.fromRGBO(
                                                    68, 138, 255, 1)
                                                : const Color.fromRGBO(
                                                    68, 138, 255, 0.1),
                                            shape: BoxShape.circle),
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${index + 9}:00',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 13,
                                                color: _currentIndex == index
                                                    ? Colors.white
                                                    : Config.primaryColor,
                                              ),
                                            ),
                                            Text(
                                              '${index + 9 > 11 ? "PM" : "AM"}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 13,
                                                color: _currentIndex == index
                                                    ? Colors.white
                                                    : Config.primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                childCount: 8,
                              ),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 1,
                              ),
                            ),
                      SliverToBoxAdapter(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Button(
                              color: Colors.white,
                              backgroundColor: Config.primaryColor,
                              borderRadius: BorderRadius.circular(6),
                              width: double.infinity,
                              title: 'Confirm',
                              padding: EdgeInsets.symmetric(vertical: 13),
                              disable:
                                  _timeSelected && _dateSelected ? false : true,
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed('success_appointment');
                              }),
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ),
            // _isWeekend
            //     ? SliverToBoxAdapter(
            //         child: Container(
            //           alignment: Alignment.center,
            //           child: const Text(
            //             "Weekend is not available, please select another date",
            //             style: TextStyle(
            //               fontSize: 18,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.grey,
            //             ),
            //           ),
            //         ),
            //       )
            //     : SliverGrid(
            //         delegate: SliverChildBuilderDelegate(
            //           (context, index) {
            //             return Stack(
            //               children: [
            //                 Container(
            //                   color: Colors.amber,
            //                   child: InkWell(
            //                     splashColor: Colors.transparent,
            //                     onTap: () {
            //                       setState(() {
            //                         // when selected, update current index and set time selected to true
            //                         _currentIndex = index;
            //                         _timeSelected = true;
            //                       });
            //                     },
            //                     child: Container(
            //                       margin: const EdgeInsets.all(5),
            //                       decoration: BoxDecoration(
            //                           border: Border.all(
            //                             color: _currentIndex == index
            //                                 ? Colors.white
            //                                 : Colors.black,
            //                           ),
            //                           borderRadius: BorderRadius.circular(15),
            //                           color: _currentIndex == index
            //                               ? Config.primaryColor
            //                               : null),
            //                       alignment: Alignment.center,
            //                       child: Text(
            //                         '${index + 9}:00${index + 9 > 11 ? "PM" : "AM"}',
            //                         style: TextStyle(
            //                           fontWeight: FontWeight.bold,
            //                           color: _currentIndex == index
            //                               ? Colors.white
            //                               : null,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             );
            //           },
            //           childCount: 8,
            //         ),
            //         gridDelegate:
            //             const SliverGridDelegateWithFixedCrossAxisCount(
            //                 crossAxisCount: 4, childAspectRatio: 1.5),
            //       ),
            // SliverGrid(
            //   delegate: SliverChildBuilderDelegate(
            //     (context, index) {
            //       return InkWell(
            //         splashColor: Colors.transparent,
            //         onTap: () {
            //           setState(() {
            //             // when selected, update current index and set time selected to true
            //             _currentIndex = index;
            //             _timeSelected = true;
            //           });
            //         },
            //         child: Container(
            //           margin: const EdgeInsets.all(5),
            //           decoration: BoxDecoration(
            //               border: Border.all(
            //                 color: _currentIndex == index
            //                     ? Colors.white
            //                     : Colors.black,
            //               ),
            //               borderRadius: BorderRadius.circular(15),
            //               color: _currentIndex == index
            //                   ? Config.primaryColor
            //                   : null),
            //           alignment: Alignment.center,
            //           child: Text(
            //             '${index + 9}:00${index + 9 > 11 ? "PM" : "AM"}',
            //             style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               color: _currentIndex == index ? Colors.white : null,
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //     childCount: 8,
            //   ),
            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 4, childAspectRatio: 1.5),
            // ),

            // SliverToBoxAdapter(
            //   child: Container(
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
            //     child: Button(
            //         color: Colors.white,
            //         backgroundColor: Config.primaryColor,
            //         borderRadius: BorderRadius.circular(10),
            //         width: double.infinity,
            //         title: 'Make Appointment',
            //         disable: _timeSelected && _dateSelected ? false : true,
            //         onPressed: () {
            //           Navigator.of(context).pushNamed('success_appointment');
            //         }),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget _tableCalendar() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10.0), // Set the desired border radius value
      ),
      child: TableCalendar(
        focusedDay: _focusDay,
        firstDay: DateTime.now(),
        lastDay: DateTime(2023, 12, 31),
        calendarFormat: _format,
        currentDay: _currentDay,
        rowHeight: 48,
        headerStyle: HeaderStyle(
          headerMargin: EdgeInsets.only(bottom: 10),
          formatButtonVisible: false,
          titleTextStyle: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.white, // Set the text color
              fontSize: 20, // Set the font size
              fontWeight: FontWeight.w500, // Set the font weight
            ),
          ),
          leftChevronIcon: Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right,
            color: Colors.white,
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
        ),
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Config.primaryColor,
            shape: BoxShape.circle,
          ),
        ),
        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
        },
        onFormatChanged: (format) {
          setState(() {
            _format = format;
          });
        },
        onDaySelected: ((selectedDay, focusedDay) {
          setState(() {
            _currentDay = selectedDay;
            _focusDay = focusedDay;
            _dateSelected = true;

            //  check if weekend is selected
            if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
              _isWeekend = true;
              _timeSelected = false;
              _currentIndex = null;
            } else {
              _isWeekend = false;
            }
          });
        }),
      ),
    );
  }
}

class YourSliverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Your Sliver Screen'),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 200, // Set the desired height for your stack
              color: Colors
                  .grey[200], // Set the background color for the sliver section
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 50,
                    left: 50,
                    child: Text(
                      'Stacked Item',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    right: 50,
                    child: Icon(Icons.ac_unit, size: 48),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('List Item $index'),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
