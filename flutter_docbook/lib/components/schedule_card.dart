// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/config.dart';
import 'button.dart';

class ScheduleCard extends StatefulWidget {
  const ScheduleCard({super.key});

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      // ignore: sort_child_properties_last
      child: Card(
        elevation: 15,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                color: Color.fromRGBO(175, 175, 175, 0.9),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.calendar,
                        color: Color.fromRGBO(134, 150, 187, 1),
                        size: 14,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "day, date and month",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(134, 150, 187, 1),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.clock,
                        color: Color.fromRGBO(134, 150, 187, 1),
                        size: 14,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "day, date and month",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(134, 150, 187, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Button(
                width: double.infinity,
                title: "Details",
                disable: false,
                color: Config.primaryColor,
                backgroundColor: Color.fromRGBO(239, 247, 255, 1),
                borderRadius: BorderRadius.circular(40),
                onPressed: () {},
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
      margin: EdgeInsets.only(bottom: 10),
    );
  }
}
