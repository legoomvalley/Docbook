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
import '../components/confirmation_dialog.dart';
import '../components/custom_appbar.dart';
import '../components/review_list.dart';
import '../main.dart';
import '../utils/config.dart';

class PatientUpdateAppointment extends StatefulWidget {
  const PatientUpdateAppointment({Key? key, this.scheduleData})
      : super(key: key);

  final Map? scheduleData;
  @override
  State<PatientUpdateAppointment> createState() =>
      _PatientUpdateAppointmentState();
}

class _PatientUpdateAppointmentState extends State<PatientUpdateAppointment> {
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  late bool completed;
  late bool notApproved;
  late bool approved;
  String userComment = '';

  final _formKey = GlobalKey<FormState>();
  final _dialogFormKey = GlobalKey<FormState>();
  final _dialogController = TextEditingController();
  late final TextEditingController _diseaseController =
      TextEditingController(text: widget.scheduleData?['disease'] ?? '');
  String? token;
  final CalendarFormat _format = CalendarFormat.month;
  late DateTime _focusDay = DateTime.parse(widget.scheduleData?['date'] ?? '');
  late DateTime _currentDay =
      DateTime.parse(widget.scheduleData?['date'] ?? '');
  late final DateTime _firstDay = DateTime.now();

  Future<void> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
  }

  @override
  void initState() {
    getToken();
    super.initState();
    completed = widget.scheduleData?['status'] == 'completed';
    notApproved = widget.scheduleData?['status'] == 'not approved';
    approved = widget.scheduleData?['status'] == 'approved';
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      // ignore: prefer_const_constructors
      appBar: CustomAppBar(
        appTitle: 'Appointment',
        icon: const FaIcon(Icons.arrow_back_ios),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                // ignore: avoid_unnecessary_containers
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
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Image(
                                image: widget.scheduleData?['doctor_profile'] ==
                                        null
                                    ? const AssetImage('assets/user.jpg')
                                    : NetworkImage(
                                            'http://10.0.2.2:8000/storage/${widget.scheduleData?['doctor_profile']}')
                                        as ImageProvider<Object>,
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
                                'Dr ${widget.scheduleData?['doctor_name']}',
                                style: GoogleFonts.rubik(
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Total experience : ${widget.scheduleData?['experience_year']} year',
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
                                widget.scheduleData?['specialization_name'],
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

                completed || notApproved
                    ? Container()
                    : (approved)
                        ? Container(
                            padding: const EdgeInsets.only(
                                top: 20, left: 12, right: 12),
                            child: Column(
                              children: [
                                Button(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  width: double.infinity,
                                  title: 'Mark as completed',
                                  disable: false,
                                  color: Colors.white,
                                  backgroundColor: Config.primaryColor,
                                  onPressed: () async {
                                    await showConfirmationDialog(context,
                                        'Do you want to mark this as completed?',
                                        () async {
                                      final response = await DioProvider()
                                          .updatePatientAppointmentStatus(
                                              widget.scheduleData?['id'],
                                              token!);
                                      if (response) {
                                        MyApp.navigatorKey.currentState!.pushNamed(
                                            'appointment_msg',
                                            arguments:
                                                'Successfully mark as completed');
                                      }
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(5),
                                  fontWeight: FontWeight.normal,
                                ),
                                const SizedBox(height: 15),
                                const Center(
                                  child: Text(
                                    'OR',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Button(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  width: double.infinity,
                                  title: 'Give Review',
                                  disable: false,
                                  color: Config.primaryColor,
                                  backgroundColor: Colors.white,
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                              'Comment the Doctor',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Form(
                                                  key: _dialogFormKey,
                                                  child: TextFormField(
                                                    controller:
                                                        _dialogController,
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText:
                                                                'Your Comment'),
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Please enter a comment';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    if (_dialogFormKey
                                                        .currentState!
                                                        .validate()) {
                                                      final comment = await DioProvider()
                                                          .storeComment(
                                                              widget.scheduleData?[
                                                                  'doctor_id'],
                                                              _dialogController
                                                                  .text,
                                                              token!);
                                                      if (comment) {
                                                        MyApp.navigatorKey
                                                            .currentState!
                                                            .pushNamed(
                                                                'appointment_msg',
                                                                arguments:
                                                                    'Your comment will appear after we approve it, please wait');
                                                      }
                                                    }
                                                  },
                                                  child: const Text('Submit'),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  borderRadius: BorderRadius.circular(5),
                                  fontWeight: FontWeight.bold,
                                  borderSideColor: Config.primaryColor,
                                ),
                              ],
                            ),
                          )
                        :
                        // calendar section -------------------------------------------------------------------
                        Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 15),
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
                approved
                    ? Container()
                    : notApproved
                        ? Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              children: [
                                const SizedBox(height: 25),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "doctor's response",
                                      style: GoogleFonts.rubik(
                                        textStyle: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black12,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Text(
                                    widget.scheduleData?['remark'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        :
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
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 4),
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
                                title: 'Update',
                                padding:
                                    const EdgeInsets.symmetric(vertical: 13),
                                disable: _timeSelected && _dateSelected
                                    ? false
                                    : true,
                                onPressed: () async {
                                  // convert date & time into string
                                  final getDate =
                                      DateConverter.getDate(_currentDay);
                                  final getTime =
                                      DateConverter.getTime(_currentIndex!);

                                  final booking = await DioProvider()
                                      .updatePatientAppointment(
                                          widget.scheduleData?['id'],
                                          getDate,
                                          getTime,
                                          _diseaseController.text,
                                          token!);
                                          print(booking);
                                  if (booking) {
                                    MyApp.navigatorKey.currentState!.pushNamed(
                                        'appointment_msg',
                                        arguments: 'Successfully Updated');
                                  }
                                }),
                          ),
              ],
            ),
          ),
          completed
              ? SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Your Reviews',
                              style: GoogleFonts.rubik(
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ReviewList(
                          comment: 'fjkdlafjklas;jf',
                          date: 'f',
                          patientName: 'lorem',
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          margin: const EdgeInsets.only(bottom: 20),
                          border: Border.all(
                            color: const Color.fromRGBO(228, 228, 228, 1),
                            width: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SliverToBoxAdapter()
        ],
      ),
    );
  }
}
