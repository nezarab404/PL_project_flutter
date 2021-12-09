// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';

class InputForm extends StatefulWidget {
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

  InputForm({
    required this.screenWidth,
    required this.screenName,
    this.hintText,
    this.pIcon,
  });

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  @override
  Widget build(BuildContext context) {
    return widget.screenName != InputForm.veriScreen
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
                  textInputAction: TextInputAction.next,
                  obscureText: widget.hintText == InputForm.password ||
                      widget.hintText == InputForm.confPassword ||
                      widget.hintText == InputForm.newPassword ||
                      widget.hintText == InputForm.confNewPassword,
                  keyboardType: widget.hintText == InputForm.email ||
                          widget.hintText == InputForm.emailOrUsername
                      ? TextInputType.emailAddress
                      : TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: widget.pIcon,
                    contentPadding: const EdgeInsets.all(10),
                    labelText: widget.hintText,
                    labelStyle: const TextStyle(
                      color: Colors.black26,
                    ),
                  ),
                ),
                if (widget.hintText == InputForm.password ||
                    widget.hintText == InputForm.confPassword ||
                    widget.hintText == InputForm.newPassword ||
                    widget.hintText == InputForm.confNewPassword)
                  IconButton(
                    onPressed: () {},
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
              child: TextFormField(
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
