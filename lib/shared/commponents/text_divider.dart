import 'package:flutter/material.dart';
import 'package:programming_languages_project/shared/constants.dart';
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
          style: TextStyle(
            color: theme.textTheme.bodyText1!.color,
          ),
        ),
        Divider(
          thickness: 3,
          color: theme == darkTheme ? darkBlue2 : Colors.black,
          indent: 40,
          endIndent: 40,
        ),
      ],
    );
  }
}
