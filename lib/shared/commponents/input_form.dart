// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class InputForm extends StatefulWidget {
  final double screenWidth;
  final String? hintText;
  final String? screenName;
  final IconData? pIcon;
  bool isPassword;



   InputForm({
    required this.screenWidth,
    required this.screenName,
    this.hintText,
    this.pIcon,
    this.isPassword = false,
  });

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {

  static const veriScreen = "VerificationCodeScreen",
      regiScreen = "RegisterScreen",
      logiScreen = "LoginScreen",
      newPassScreen = "ForgotPasswordScreen";

  static const password = "Password",
      email = "Email",
      emailOrUsername = "Email or username",
      confPassword = "Confirm password",
      newPassword = "New password",
      confNewPassword = "Confirm new password";

  @override
  Widget build(BuildContext context) {
    return widget.screenName !=veriScreen
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
                TextField(
                  obscureText: widget.isPassword,

                  keyboardType: widget.hintText == email || widget.hintText == emailOrUsername
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
                      });
                    },
                    icon: const Icon(Icons.visibility),
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
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
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
