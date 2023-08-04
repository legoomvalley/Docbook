import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/button.dart';
import 'package:lottie/lottie.dart';

import '../utils/config.dart';

class SuccessAppointment extends StatelessWidget {
  const SuccessAppointment({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: const Text('Successfully Booked',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
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
                onPressed: () => Navigator.of(context).pushNamed('main'),
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
