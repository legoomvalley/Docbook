import 'package:flutter/material.dart';

Future<void> showConfirmationDialog(
    BuildContext context, String question, Function onConfirm) async {
  return showDialog<void>(
    context: context,
    barrierDismissible:
        false, // Prevent dialog from closing when tapped outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Are you sure?'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(question),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Confirm'),
            onPressed: () {
              onConfirm(); // Call the provided callback when Confirm is pressed
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
