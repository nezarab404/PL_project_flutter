// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  final double screenWidth;
  final String hintText;
  const InputForm({required this.screenWidth, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Card(
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
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black26,
          ),
        ),
      ),
    );
  }
}
