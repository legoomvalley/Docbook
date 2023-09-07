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
          padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
          child: Column(
            children: [
              const Row(
                children: <Widget>[
                  SizedBox(
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/user.jpg'),
                    ),
                  ),
                  const Flexible(
                    child: const Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Column(
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
              const SizedBox(height: 13),
              const Divider(
                color: Color.fromRGBO(175, 175, 175, 0.9),
              ),
              const SizedBox(height: 10),
              const Row(
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
              const SizedBox(height: 10),
              Button(
                width: double.infinity,
                title: "Details",
                disable: false,
                color: Config.primaryColor,
                backgroundColor: const Color.fromRGBO(239, 247, 255, 1),
                borderRadius: BorderRadius.circular(40),
                onPressed: () {},
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      margin: const EdgeInsets.only(bottom: 10),
    );
  }
}
