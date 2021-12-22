import 'package:flutter/material.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';

// ignore: must_be_immutable
class MBSElement extends StatelessWidget {
  IconData? icon;
  String? text;
  Function()? onPressed;

  MBSElement({Key? key, required this.icon, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 70,
          onPressed: onPressed,
          icon: Icon(
            icon,
          ),
        ),
        Text(
          text!,
          style: TextStyle(
            color: mainGrey,
          ),
        ),
      ],
    );
  }
}