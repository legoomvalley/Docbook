import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/button.dart';
import 'package:flutter_docbook/utils/config.dart';

import '../screens/doctor_details_page.dart';
import '../screens/patient_make_appointment_page.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key, required this.doctor, required this.route});
  final Map<String, dynamic> doctor;
  final String route;
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 15,
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: EdgeInsets.only(left: 15, top: 15, right: 15),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    SizedBox(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/user.jpg'),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Dr ${doctor['doctor_name']}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "${doctor['specialization_name']}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(134, 150, 187, 1),
                              ),
                            ),
                            SizedBox(height: 13),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 13),
                Divider(
                  color: Color.fromRGBO(175, 175, 175, 0.3),
                ),
                Button(
                  width: double.infinity,
                  title: "Book Now",
                  disable: false,
                  color: Config.primaryColor,
                  backgroundColor: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(40),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PatientMakeAppointment(doctor: doctor),
                      ),
                    );
                  },
                ),
                Button(
                  width: double.infinity,
                  title: "Details",
                  disable: false,
                  color: Colors.green,
                  backgroundColor: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(40),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorDetails(doctor: doctor),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      margin: EdgeInsets.only(bottom: 10),
    );
  }
}
