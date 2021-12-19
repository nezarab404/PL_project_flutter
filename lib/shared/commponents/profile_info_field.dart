import 'package:flutter/material.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';
class ProfileInfoField extends StatelessWidget {
  const ProfileInfoField({
    Key? key,
    required this.title,
    required this.text,
    required this.icon,
    this.suffix,
    this.function,
  }) : super(key: key);

  final String? title;
  final String? text;
  final IconData? icon;
  final IconData? suffix;
  final Function()? function;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        elevation: 0,
        padding: EdgeInsets.zero,
        shadowColor: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(
                icon,
                color: mainRed,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: Text(
                    text!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            //suffix icon
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(
            //     suffix,
            //     color: mainRed,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}