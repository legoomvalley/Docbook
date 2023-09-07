import 'package:flutter/material.dart';

class SelectTime extends StatefulWidget {
  SelectTime(
      {super.key,
      required this.isWeekend,
      required this.button,
      required this.buttonNumber});

  bool isWeekend;
  Widget button;
  List<Widget> buttonNumber;
  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 62, vertical: 12),
      alignment: Alignment.center,
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(0, -3),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(45), topRight: Radius.circular(45)),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.isWeekend
                ? Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Weekend is not available, please select another date",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : SizedBox(
                    height: 200,
                    child: GridView.count(
                      crossAxisCount: 4,
                      children: widget.buttonNumber,
                    ),
                  ),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: widget.button)
          ]),
    );
  }
}
