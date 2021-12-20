import 'package:flutter/material.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';

class ProfileInfoField extends StatefulWidget {
  ProfileInfoField({
    Key? key,
    required this.title,
    required this.text,
    required this.icon,
    // this.suffix,
    required this.onEdit,
    required this.controller,
    this.function,
  }) : super(key: key);

  final String? title;
  String? text;
  final IconData? icon;
  final bool onEdit;
  final TextEditingController controller;
  // final IconData? suffix;
  final Function()? function;

  @override
  State<ProfileInfoField> createState() => _ProfileInfoFieldState();
}

class _ProfileInfoFieldState extends State<ProfileInfoField> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.function,
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
                widget.icon,
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
                  widget.title!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: widget.onEdit
                      ? TextFormField(
                          controller: widget.controller,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                          ),
                        )
                      : Text(
                          widget.controller.text.isEmpty
                              ? widget.text!
                              : widget.controller.text,
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
