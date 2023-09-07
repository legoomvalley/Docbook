import 'package:flutter/material.dart';
import 'package:flutter_docbook/utils/config.dart';

class ExpandedWidget extends StatefulWidget {
  const ExpandedWidget({super.key, required this.text, this.style});

  final String text;
  final TextStyle? style;

  @override
  State<ExpandedWidget> createState() => _ExpandedWidgetState();
}

class _ExpandedWidgetState extends State<ExpandedWidget> {
  late String firstHalf;
  late String secondHalf;
  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 150) {
      firstHalf = widget.text.substring(0, 150);
      secondHalf = widget.text.substring(151, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.length <= 150
          ? Text(widget.text)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AnimatedSize(
                  curve: Curves.easeOut,
                  duration: const Duration(seconds: 1),
                  child: Text(
                    flag ? firstHalf : widget.text,
                  ),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                  child: Text(
                    flag ? "show more" : "show less",
                    style: const TextStyle(color: Config.primaryColor),
                  ),
                )
              ],
            ),
    );
  }
}
