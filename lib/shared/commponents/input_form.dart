// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  final double screenWidth;
  final String? hintText;
  final String? screenName;
  final Icon? pIcon;

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

  const InputForm({
    required this.screenWidth,
    required this.screenName,
    this.hintText,
    this.pIcon,
  });

  @override
  Widget build(BuildContext context) {
    return screenName != veriScreen
        ? Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 6,
            margin: EdgeInsets.symmetric(
              horizontal: screenWidth / 10,
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  obscureText: hintText == password ||
                          hintText == confPassword ||
                          hintText == newPassword ||
                          hintText == confNewPassword
                      ? true
                      : false,
                  keyboardType: hintText == email || hintText == emailOrUsername
                      ? TextInputType.emailAddress
                      : TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: pIcon,
                    contentPadding: const EdgeInsets.all(10),
                    labelText: hintText,
                    labelStyle: const TextStyle(
                      color: Colors.black26,
                    ),
                  ),
                ),
                if (hintText == password ||
                    hintText == confPassword ||
                    hintText == newPassword ||
                    hintText == confNewPassword)
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.visibility),
                    color: Colors.black26,
                  ),
              ],
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
