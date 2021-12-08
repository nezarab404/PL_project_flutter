// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  final double screenWidth;
  final String? hintText;
  final String? screenName;

  final veriScreen = "VerificationCodeScreen",
      regiScreen = "RegisterScreen",
      logiScreen = "LoginScreen";

  const InputForm(
      {required this.screenWidth, required this.screenName, this.hintText});

  @override
  Widget build(BuildContext context) {
    return screenName == logiScreen || screenName == regiScreen
        ? Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 6,
            margin: EdgeInsets.symmetric(
              horizontal: screenWidth / 10,
            ),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                // hintText: hintText,
                // hintStyle: const TextStyle(
                //   color: Colors.black26,
                // ),
                labelText: hintText,
                labelStyle: const TextStyle(
                  color: Colors.black26,
                ),
              ),
            ),
          )
        : SizedBox(
            height: screenWidth / 7,
            width: screenWidth / 7,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
            ),
          );
  }
}
