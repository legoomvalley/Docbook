import 'package:flutter/material.dart';

import '../screens/doctor_details_page.dart';

class DoctorHomeListCard extends StatelessWidget {
  const DoctorHomeListCard(
      {super.key, required this.route, this.isLastCard, required this.doctor});

  final String route;
  final bool? isLastCard;
  final Map<String, dynamic> doctor;

  @override
  Widget build(BuildContext context) {
    final double paddingRight = isLastCard == true ? 19 : 0;
    final doctorName = doctor['doctor_name'];
    final nameWords = doctorName.split(' ');
    final firstTwoWords = nameWords.take(2).join(' ');
    return Container(
      padding: EdgeInsets.only(left: 19, bottom: 25, right: paddingRight),
      child: SizedBox(
        child: GestureDetector(
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(10),
              child: Column(
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 4 / 4,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10.0)),
                        child: Image.asset(
                          'assets/doctor.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(firstTwoWords,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 5),
                  Text(
                    doctor['specialization_name'],
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorDetails(doctor: doctor),
                ),
              );
            }),
      ),
    );
  }
}
