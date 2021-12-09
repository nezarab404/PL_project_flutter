// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';

class InputForm extends StatefulWidget {
  final double screenWidth;
  final String? hintText;
  final String? screenName;
  final IconData? pIcon;
  final TextEditingController? controller;
  bool isPassword;

  InputForm({
    required this.screenWidth,
    required this.screenName,
    this.controller, //TODO: REQUIRED
    this.hintText,
    this.pIcon,
    this.isPassword = false,
  });

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  static const veriScreen = "VerificationCodeScreen";
  static const password = "Password",
      email = "Email",
      emailOrUsername = "Email or username",
      confPassword = "Confirm password",
      newPassword = "New password",
      confNewPassword = "Confirm new password";

  var icon = Icons.visibility;

  @override
  Widget build(BuildContext context) {
    return widget.screenName != veriScreen
        ? Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 6,
            margin: EdgeInsets.symmetric(
              horizontal: widget.screenWidth / 10,
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                TextFormField(
                  controller: widget.controller,
                  textInputAction: TextInputAction.next,
                  obscureText: widget.hintText == password ||
                      widget.hintText == confPassword ||
                      widget.hintText == newPassword ||
                      widget.hintText == confNewPassword,
                  keyboardType: widget.hintText == email ||
                          widget.hintText == emailOrUsername
                      ? TextInputType.emailAddress
                      : TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(widget.pIcon),
                    contentPadding: const EdgeInsets.all(10),
                    labelText: widget.hintText,
                    labelStyle: const TextStyle(
                      color: Colors.black26,
                    ),
                  ),
                ),
                if (widget.hintText == password ||
                    widget.hintText == confPassword ||
                    widget.hintText == newPassword ||
                    widget.hintText == confNewPassword)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.isPassword = !widget.isPassword;
                        icon == Icons.visibility_off
                            ? icon = Icons.visibility
                            : icon = Icons.visibility_off;
                      });
                    },
                    icon: Icon(icon,
                        color:
                            icon == Icons.visibility ? mainRed : Colors.grey),
                    color: Colors.black26,
                  ),
              ],
            ),
          )
        : SizedBox(
            height: widget.screenWidth / 7,
            width: widget.screenWidth / 7,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextFormField(
                controller: widget.controller,
                maxLength: 1,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: mainRed,
                  fontSize: 28,
                ),
              ),
            ),
          );
  }
}
