import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button(
      {Key? key,
      this.width,
      required this.title,
      required this.disable,
      required this.color,
      required this.backgroundColor,
      required this.onPressed,
      required this.borderRadius,
      this.borderSideColor,
      this.padding,
      this.margin,
      this.elevation,
      this.fontWeight})
      : super(key: key);

  final double? width;
  final String title;
  final bool disable;
  final Color color;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Function() onPressed;
  final Color? borderSideColor;
  final FontWeight? fontWeight;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: padding,
            backgroundColor: backgroundColor,
            elevation: elevation,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
              side: BorderSide(color: borderSideColor ?? Colors.transparent),
            )),
        onPressed: disable ? null : onPressed,
        child: Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: fontWeight == null ? FontWeight.w500 : fontWeight,
          ),
        ),
      ),
    );
  }
}
