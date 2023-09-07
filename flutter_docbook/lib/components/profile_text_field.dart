import 'package:flutter/material.dart';

import '../utils/config.dart';

class ProfileTextField extends StatefulWidget {
  const ProfileTextField(
      {super.key,
      required this.labelText,
      // required this.onPressed,
      required this.textField,
      required this.iconButton});

  final String labelText;
  final Widget textField;
  final IconButton iconButton;
  // final void Function() onPressed;

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      width: double.infinity,
      child: Card(
        elevation: 30,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.labelText,
                      style: const TextStyle(
                        color: Config.primaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 25,
                      child: widget.textField,
                    ),
                    // Text(
                    //   widget.data,
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.w200,
                    //   ),
                    // ),
                  ],
                ),
              ),
              // const SizedBox(
              //     width: 10),
              SizedBox(height: 30, child: widget.iconButton)
            ],
          ),
        ),
      ),
    );
  }
}
