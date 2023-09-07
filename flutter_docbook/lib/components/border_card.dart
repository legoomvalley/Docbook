import 'package:flutter/material.dart';

class BorderCard extends StatelessWidget {
  const BorderCard({
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
          Container(
            margin: const EdgeInsets.all(10),
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
