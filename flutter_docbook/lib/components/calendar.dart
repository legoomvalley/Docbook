import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils/config.dart';

class Calendar extends StatefulWidget {
  Calendar({
    super.key,
    required this.format,
    required this.focusDay,
    required this.currentDay,
    required this.firstDay,
    required this.onDaySelected,
    required this.dateSelected,
    required this.isWeekend,
    required this.timeSelected,
    required currentIndex,
  });

  CalendarFormat format;
  DateTime focusDay;
  DateTime currentDay;
  DateTime firstDay;
  bool dateSelected;
  bool isWeekend;
  bool timeSelected;
  int? currentIndex;
  final void Function(DateTime, DateTime) onDaySelected;
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  // int? _currentIndex;
  // bool _isWeekend = false;
  // bool _dateSelected = false;
  // bool _timeSelected = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10.0), // Set the desired border radius value
      ),
      child: TableCalendar(
          focusedDay: widget.focusDay,
          firstDay: widget.firstDay,
          lastDay: DateTime(2030, 12, 1),
          calendarFormat: widget.format,
          currentDay: widget.currentDay,
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
              widget.format = format;
            });
          },
          onDaySelected: widget.onDaySelected),

      // (selectedDay, focusedDay) {
      //   setState(() {
      //     widget.currentDay = selectedDay;
      //     widget.focusDay = focusedDay;
      //     widget.dateSelected = true;
      //     if (selectedDay.weekday == 5 || selectedDay.weekday == 6) {
      //       widget.isWeekend = true;
      //       widget.timeSelected = false;
      //       widget.currentIndex = null;
      //     } else {
      //       widget.isWeekend = false;
      //     }
      //   });

      //   print(widget.focusDay);
      // },

      // onDaySelected: (selectedDay, focusedDay) {
      //   setState(() {
      //     widget.currentDay = selectedDay;
      //     widget.focusDay = focusedDay;
      //     widget.dateSelected = true;
      //   });
      //   // widget.onDaySelected(selectedDay, focusedDay);
      //   if (selectedDay.weekday == 5 || selectedDay.weekday == 6) {
      //     widget.isWeekend = true;
      //     widget.timeSelected = false;
      //     widget.currentIndex = null;
      //   } else {
      //     widget.isWeekend = false;
      //   }
      //   print(widget.focusDay);
      // },
      // onDaySelected: (selectedDay, focusedDay) {
      //   setState(() {
      //     widget.currentDay = selectedDay;
      //     widget.focusDay = focusedDay;
      //     // _dateSelected = true
      //     // widget.onDaySelected(selectedDay, focusedDay);
      //   });
      // }),
    );
  }
}
