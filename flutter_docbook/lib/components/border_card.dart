import 'package:flutter/material.dart';

import '../utils/config.dart';

class BorderCard extends StatelessWidget {
  BorderCard({
    Key? key,
    required this.topWidget,
    required this.btmWidget,
    required this.cardHeader,
  }) : super(key: key);

  final List<Widget> topWidget;
  final List<Widget> btmWidget;
  final Widget cardHeader;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: Colors.black12,
          )),
      child: Column(
        children: [
          cardHeader,
          // Container(
          //   alignment: Alignment.centerRight,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          //     color: const Color.fromRGBO(94, 94, 184, 0.3),
          //   ),
          //   width: double.infinity,
          //   padding: EdgeInsets.all(10),
          //   child: Container(
          //     width: 30,
          //     height: 30,
          //     child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //           padding: EdgeInsets.all(0),
          //           backgroundColor: Colors.yellow[50],
          //           side: BorderSide(color: Colors.yellow.shade600, width: 2),
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(7),
          //           )),
          //       child: Icon(
          //         Icons.edit_calendar_sharp,
          //         size: 17,
          //         color: Colors.yellow[600],
          //       ),
          //       onPressed: () {},
          //     ),
          //   ),
          // ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: topWidget,
                ),
                Column(
                  children: btmWidget,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
