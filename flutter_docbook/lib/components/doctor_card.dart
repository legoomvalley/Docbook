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
      margin: const EdgeInsets.only(bottom: 10),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 15,
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    SizedBox(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: doctor['doctor_profile'] == null
                            ? AssetImage('assets/user.jpg')
                            : NetworkImage(
                                'http://10.0.2.2:8000/storage/${doctor['doctor_profile']}',
                              ) as ImageProvider<Object>,
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${doctor['doctor_name']}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${doctor['specialization_name']}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(134, 150, 187, 1),
                              ),
                            ),
                            const SizedBox(height: 13),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 13),
                const Divider(
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
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
