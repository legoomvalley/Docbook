import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/button.dart';
import 'package:flutter_docbook/components/date_time_ui.dart';
import 'package:flutter_docbook/models/auth_model.dart';
import 'package:flutter_docbook/components/datetime_converter.dart';
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
  final TextEditingController _additionalMsgController =
      TextEditingController();
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
    _additionalMsgController.text =
        widget.appointment?['remark'] == 'not updated yet'
            ? ''
            : widget.appointment?['remark'];
    selectedDate = DateConverter.stringToDate(widget.appointment?['date']);
    selectedTime = DateConverter.parseTimeOfDay(widget.appointment?['time']);
  }

  @override
  Widget build(BuildContext context) {
    String? convertedDate = DateConverter.formatDate(selectedDate.toString());
    String? convertedTime = selectedTime!.format(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.doctorTheme,
        elevation: 5,
        title: const Text('Appointment details'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
                    margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.check_circle_outline,
                                          color: _selectedApproved
                                              ? Config.doctorTheme
                                              : Colors.black),
                                      const SizedBox(width: 15),
                                      const Text(
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.cancel_outlined,
                                          color: _selectedNotApproved
                                              ? Config.doctorTheme
                                              : Colors.black),
                                      const SizedBox(width: 15),
                                      const Text(
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
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Patient Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
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
                            const Icon(
                              Icons.person_3_outlined,
                            ),
                            const SizedBox(width: 5),
                            Text(widget.appointment?['full_name']),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Config.spaceSmall,
                  const Text(
                    'Disease',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
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
                            const Icon(
                              Icons.medical_information_outlined,
                            ),
                            const SizedBox(width: 5),
                            Text(widget.appointment?['disease']),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Config.spaceSmall,
                  const Text(
                    'Time',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
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
                            const Icon(
                              Icons.timelapse_outlined,
                            ),
                            const SizedBox(width: 5),
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
                  const Text(
                    'Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
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
                            const Icon(
                              Icons.calendar_month_outlined,
                            ),
                            const SizedBox(width: 5),
                            Text(convertedDate),
                          ],
                        ),
                        Button(
                            title: 'Change Date',
                            disable:
                                widget.appointment?['status'] == "completed"
                                    ? true
                                    : false,
                            color: Colors.white,
                            backgroundColor: Config.doctorTheme,
                            onPressed: () async {
                              final date =
                                  await pickDate(context, _handleDateSelected);
                            },
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)))
                      ],
                    ),
                  ),
                  Config.spaceSmall,
                  const Text(
                    'Additional message',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
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
                        prefixIcon: const Padding(
                            padding: EdgeInsets.only(bottom: 80),
                            child: Icon(
                              Icons.add_box_outlined,
                              color: Colors.black,
                            )),
                        prefixIconColor: Config.doctorTheme,
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
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
                          padding: const EdgeInsets.symmetric(vertical: 10),
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
                                });
                                snackBar(context, 'data successfully sent',
                                    Colors.green, Duration(seconds: 4));
                                MyApp.navigatorKey.currentState!
                                    .pushNamed('main_doctor');
                              }
                            }
                          },
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
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
