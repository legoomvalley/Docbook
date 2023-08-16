import 'package:flutter/material.dart';

snackBar(BuildContext context, String text, Color backgroundColor,
    dynamic duration) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        backgroundColor: backgroundColor,
        content: Text(text),
        duration: duration),
  );
}
