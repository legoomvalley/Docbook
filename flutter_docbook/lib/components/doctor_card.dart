import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/button.dart';
import 'package:flutter_docbook/utils/config.dart';

class DoctorCard extends StatefulWidget {
  const DoctorCard({super.key});

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
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
                          children: const <Widget>[
                            Text(
                              'Dr Username',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Dr Specialization',
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
                // SizedBox(height: 5),
                // Text('this is button'),
                Button(
                  width: double.infinity,
                  title: "Book Now",
                  disable: false,
                  color: Config.primaryColor,
                  backgroundColor: Color.fromRGBO(239, 247, 255, 1),
                  borderRadius: BorderRadius.circular(40),
                  onPressed: () {},
                ),
                Button(
                  width: double.infinity,
                  title: "Details",
                  disable: false,
                  color: Color.fromRGBO(14, 190, 127, 1),
                  backgroundColor: const Color.fromRGBO(232, 245, 233, 1),
                  borderRadius: BorderRadius.circular(40),
                  onPressed: () {},
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
