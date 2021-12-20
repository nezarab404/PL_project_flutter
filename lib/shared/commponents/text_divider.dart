import 'package:flutter/material.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';

class TextDivider extends StatelessWidget {
  final String text;
  const TextDivider({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        Divider(
          thickness: 3,
          color: darkBlue2,
          indent: 40,
          endIndent: 40,
        ),
      ],
    );
  }
}
