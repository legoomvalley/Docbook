import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/calendar.dart';
import 'package:flutter_docbook/components/select_time.dart';
import 'package:flutter_docbook/components/datetime_converter.dart';
import 'package:flutter_docbook/providers/dio_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import '../components/button.dart';
import '../components/custom_appbar.dart';
import '../main.dart';
import '../utils/config.dart';

class PatientMakeAppointment extends StatefulWidget {
  const PatientMakeAppointment({Key? key, this.doctor}) : super(key: key);

  final Map? doctor;
  @override
  State<PatientMakeAppointment> createState() => _PatientMakeAppointmentState();
}

class _PatientMakeAppointmentState extends State<PatientMakeAppointment> {
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _diseaseController = TextEditingController();
  String? token;
  final CalendarFormat _format = CalendarFormat.month;
  late DateTime _focusDay = DateTime.now();
  late DateTime _currentDay = DateTime.now();
  final DateTime _firstDay = DateTime.now();

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

    return Scaffold(
      appBar: const CustomAppBar(
        appTitle: 'Appointment',
        icon: FaIcon(Icons.arrow_back_ios),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 4,
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(children: [
                        SizedBox(
                          width: 110,
                          height: 110,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: const FittedBox(
                              fit: BoxFit.cover,
                              child: Image(
                                image: AssetImage('assets/user.jpg'),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dr ${widget.doctor?['doctor_name']}',
                                style: GoogleFonts.rubik(
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'dr reviews',
                                style: GoogleFonts.rubik(
                                  textStyle: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(103, 114, 148, 1),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 36),
                              Text(
                                widget.doctor?['specialization_name'],
                                style: GoogleFonts.rubik(
                                  textStyle: const TextStyle(
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
                  margin: const EdgeInsets.only(left: 12, right: 12, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter Your Disease',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _diseaseController,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Config.primaryColor,
                          decoration: const InputDecoration(
                            hintText: 'Disease',
                            labelText: 'Disease',
                            fillColor: Color.fromRGBO(206, 222, 239, 1),
                            alignLabelWithHint: true,
                            prefixIconColor: Config.primaryColor,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == '') {
                              return 'disease field is required';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // calendar section -------------------------------------------------------------------
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  child: Calendar(
                    format: _format,
                    focusDay: _focusDay,
                    currentDay: _currentDay,
                    firstDay: _firstDay,
                    dateSelected: _dateSelected,
                    currentIndex: _currentIndex,
                    isWeekend: _isWeekend,
                    timeSelected: _timeSelected,
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _currentDay = selectedDay;
                        _focusDay = focusedDay;
                        _dateSelected = true;
                        if (selectedDay.weekday == 5 ||
                            selectedDay.weekday == 6) {
                          _isWeekend = true;
                          _timeSelected = false;
                          _currentIndex = null;
                        } else {
                          _isWeekend = false;
                        }
                      });
                    },
                  ),
                ),

                // select time section ----------------------------------------------------------------
                SelectTime(
                  isWeekend: _isWeekend,
                  buttonNumber: List.generate(
                    10,
                    (index) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            _currentIndex = index;
                            _timeSelected = true;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                              color: _currentIndex == index
                                  ? const Color.fromRGBO(68, 138, 255, 1)
                                  : const Color.fromRGBO(68, 138, 255, 0.1),
                              shape: BoxShape.circle),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${index + 10}:30',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: _currentIndex == index
                                      ? Colors.white
                                      : Config.primaryColor,
                                ),
                              ),
                              Text(
                                index + 9 > 11 ? "PM" : "AM",
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
                      );
                    },
                  ),
                  button: Button(
                      color: Colors.white,
                      backgroundColor: Config.primaryColor,
                      borderRadius: BorderRadius.circular(6),
                      width: double.infinity,
                      title: 'Confirm',
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      disable: _timeSelected && _dateSelected ? false : true,
                      onPressed: () async {
                        // convert date & time into string
                        final getDate = DateConverter.getDate(_currentDay);
                        final getTime = DateConverter.getTime(_currentIndex!);
                        if (_formKey.currentState!.validate()) {}

                        final booking = await DioProvider().bookAppointment(
                            getDate,
                            getTime,
                            _diseaseController.text,
                            widget.doctor?['id'],
                            token!);
                        if (booking == 200) {
                          MyApp.navigatorKey.currentState!.pushNamed(
                              'success_appointment',
                              arguments: 'Successfully booked');
                        }
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
