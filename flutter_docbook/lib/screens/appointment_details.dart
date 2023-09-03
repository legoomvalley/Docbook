import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/button.dart';
import 'package:flutter_docbook/components/date_time_ui.dart';
import 'package:flutter_docbook/models/auth_model.dart';
import 'package:flutter_docbook/models/datetime_converter.dart';
import 'package:flutter_docbook/providers/dio_provider.dart';
import 'package:provider/provider.dart';

import '../components/snackBar.dart';
import '../main.dart';
import '../utils/config.dart';

class AppointmentDetails extends StatefulWidget {
  const AppointmentDetails({Key? key, this.appointment, this.token, this.index})
      : super(key: key);

  final Map? appointment;
  final String? token;
  final int? index;

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _additionalMsgController = TextEditingController();
  bool _selectedApproved = false;
  bool _selectedNotApproved = false;
  String? _selectedStatus;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool isLoading = false;

  void _handleDateSelected(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
    });
  }

  void _handleTimeSelected(TimeOfDay newTime) {
    setState(() {
      selectedTime = newTime;
    });
  }

  @override
  void initState() {
    super.initState();
    _additionalMsgController.text = widget.appointment?['remark'] ?? '';
    selectedDate = DateConverter.stringToDate(widget.appointment?['date']);
    selectedTime = DateConverter.parseTimeOfDay(widget.appointment?['time']);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.token);
    String? convertedDate = DateConverter.formatDate(selectedDate.toString());
    String? convertedTime = selectedTime!.format(context);
    print(widget.appointment);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.doctorTheme,
        elevation: 5,
        title: Text('Appointment details'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            widget.appointment?['status'] == 'completed'
                ? Container()
                : Container(
                    height: 80,
                    margin: EdgeInsets.only(top: 30, left: 10, right: 10),
                    // color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 185,
                          height: double.maxFinite,
                          child: Card(
                            color: Colors.white,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: _selectedApproved
                                    ? Config.doctorTheme
                                    : Colors.grey.shade300,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                            ),
                            child: InkWell(
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedApproved = true;
                                  _selectedStatus = 'approved';
                                  _selectedNotApproved = false;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.check_circle_outline,
                                          color: _selectedApproved
                                              ? Config.doctorTheme
                                              : Colors.black),
                                      SizedBox(width: 15),
                                      Text(
                                        'Approved',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 185,
                          height: double.infinity,
                          child: Card(
                            color: Colors.white,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: _selectedNotApproved
                                    ? Config.doctorTheme
                                    : Colors.grey.shade300,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                            ),
                            child: InkWell(
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedNotApproved = true;
                                  _selectedStatus = 'not approved';
                                  _selectedApproved = false;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.cancel_outlined,
                                          color: _selectedNotApproved
                                              ? Config.doctorTheme
                                              : Colors.black),
                                      SizedBox(width: 15),
                                      Text(
                                        'Not\napproved',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Patient Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: Colors.grey.shade200,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person_3_outlined,
                            ),
                            SizedBox(width: 5),
                            Text(widget.appointment?['full_name']),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Config.spaceSmall,
                  Text(
                    'Disease',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: Colors.grey.shade200,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.medical_information_outlined,
                            ),
                            SizedBox(width: 5),
                            Text(widget.appointment?['disease']),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Config.spaceSmall,
                  Text(
                    'Time',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: Colors.grey.shade200,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.timelapse_outlined,
                            ),
                            SizedBox(width: 5),
                            Text(convertedTime),
                          ],
                        ),
                        Button(
                            title: 'Change time',
                            disable:
                                widget.appointment?['status'] == "completed"
                                    ? true
                                    : false,
                            color: Colors.white,
                            backgroundColor: Config.doctorTheme,
                            onPressed: () async {
                              final time =
                                  await pickTime(context, _handleTimeSelected);
                            },
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)))
                      ],
                    ),
                  ),
                  Config.spaceSmall,
                  Text(
                    'Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: Colors.grey.shade200,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                            ),
                            SizedBox(width: 5),
                            Text(convertedDate ?? ''),
                          ],
                        ),
                        Container(
                          child: Button(
                              title: 'Change Date',
                              disable:
                                  widget.appointment?['status'] == "completed"
                                      ? true
                                      : false,
                              color: Colors.white,
                              backgroundColor: Config.doctorTheme,
                              onPressed: () async {
                                final date = await pickDate(
                                    context, _handleDateSelected);
                              },
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8))),
                        )
                      ],
                    ),
                  ),
                  Config.spaceSmall,
                  Text(
                    'Additional message',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      readOnly: widget.appointment?['status'] == 'completed'
                          ? true
                          : false,
                      controller: _additionalMsgController,
                      maxLines: 5,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: '',
                        labelText: '',
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        alignLabelWithHint: true,
                        prefixIcon: Padding(
                            padding: EdgeInsets.only(bottom: 80),
                            child: Icon(
                              Icons.add_box_outlined,
                              color: Colors.black,
                            )),
                        prefixIconColor: Config.doctorTheme,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      validator: (value) {
                        if (value == '') {
                          return 'additional message is required';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Config.spaceSmall,
                  widget.appointment?['status'] == "completed"
                      ? Container()
                      : Button(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          width: double.infinity,
                          title: isLoading ? 'Saving...' : 'Confirm',
                          disable: _selectedStatus == null || isLoading
                              ? true
                              : false,
                          color: Colors.white,
                          backgroundColor: Config.doctorTheme,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              await DioProvider().updateAppointment(
                                  widget.token!,
                                  widget.appointment!['id'],
                                  _selectedStatus!,
                                  selectedDate!,
                                  selectedTime!.format(context),
                                  _additionalMsgController.text);
                              final authModel = Provider.of<AuthModel>(context,
                                  listen: false);
                              final response = await DioProvider()
                                  .getUserDoctor(widget.token!);
                              if (response != null) {
                                setState(() {
                                  final user = json.decode(response);

                                  authModel.loginSuccessDoctor(
                                      user, widget.token!, user['doctor'][0]);
                                  print(user['doctor'][0]);
                                });
                                snackBar(context, 'data successfully sent',
                                    Colors.green, Duration(seconds: 4));
                                MyApp.navigatorKey.currentState!
                                    .pushNamed('main_doctor');
                              }
                            }
                          },
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                  Config.spaceSmall,
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
