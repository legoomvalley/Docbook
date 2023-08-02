import 'package:flutter/material.dart';

import '../utils/config.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.width,
    required this.title,
    required this.disable,
    required this.color,
    required this.backgroundColor,
    required this.onPressed,
    required this.borderRadius,
    this.padding,
    this.margin,
  }) : super(key: key);

  final double width;
  final String title;
  final bool disable;
  final Color color;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: padding,
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
        onPressed: disable ? null : onPressed,
        child: Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
