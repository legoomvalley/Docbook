import 'package:flutter/material.dart';
import 'package:flutter_docbook/utils/config.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentCalendar extends StatefulWidget {
  const AppointmentCalendar({super.key});

  @override
  State<AppointmentCalendar> createState() => _AppointmentCalendarState();
}

class _AppointmentCalendarState extends State<AppointmentCalendar> {
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Column(children: [
          _tableCalendar(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          )
        ]),
      ),
      _isWeekend
          ? SliverToBoxAdapter(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                alignment: Alignment.center,
                child: const Text(
                  'Weekend is not available, please select another date',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
            )
          : SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _currentIndex == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${index + 9}:00${index + 9 > 11 ? "PM" : "AM"}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _currentIndex == index ? Colors.white : null,
                        ),
                      ),
                    ),
                  );
                },
                childCount: 8,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.5,
              ),
            )
    ]);
  }

// tbl calendar
  Widget _tableCalendar() {
    return TableCalendar(
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(2023, 12, 31),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
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

          // check if weekend is selected
          if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
            _isWeekend = true;
            _timeSelected = false;
            _currentIndex = null;
          } else {
            _isWeekend = false;
          }
        });
      }),
    );
  }
}
