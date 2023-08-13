// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DoctorHomeListCard extends StatelessWidget {
  const DoctorHomeListCard({super.key, required this.route});

  final String route;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 19, bottom: 25),
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
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10.0)),
                        child: Image.asset(
                          'assets/doctor.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  // const SizedBox(height: 4),
                  SizedBox(height: 8),
                  Text("doctor name",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(height: 5),
                  Text(
                    "doctor specialist",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(route);
            }),
      ),
    );
  }
}
