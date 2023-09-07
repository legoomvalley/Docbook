import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/button.dart';
import 'package:lottie/lottie.dart';

import '../utils/config.dart';

class AppointmentMsg extends StatelessWidget {
  const AppointmentMsg({super.key});

  @override
  Widget build(BuildContext context) {
    String message = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Lottie.asset('assets/success.json'),
            ),
            Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                )),
            const Spacer(),
            // back to homePage
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Button(
                width: double.infinity,
                title: 'Back to Home Page',
                disable: false,
                color: Colors.white,
                backgroundColor: Config.primaryColor,
                onPressed: () =>
                    Navigator.of(context).pushNamed('main_patient'),
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
