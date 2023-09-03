import 'package:flutter/material.dart';

Future<void> pickDate(
    BuildContext context, Function(DateTime) onDateSelected) async {
  final selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
  );

  if (selectedDate != null) {
    onDateSelected(selectedDate);
  }
}

Future<void> pickTime(
    BuildContext context, Function(TimeOfDay) onTimeSelected) async {
  final selectedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (selectedTime != null) {
    onTimeSelected(selectedTime);
  }
}
