// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';

class InputForm extends StatefulWidget {
  final double screenWidth;
  final String? hintText;
  final IconData? pIcon;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final String? Function(String?)? validator;
  bool isPassword;
  bool isDescription;
  String? value;

  InputForm(
      {required this.screenWidth,
      this.controller,
      this.hintText,
      this.pIcon,
      this.inputType,
      this.validator,
      this.isPassword = false,
      this.isDescription = false,
      this.value});

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  static const password = "Password",
      confPassword = "Confirm password",
      newPassword = "New password",
      confNewPassword = "Confirm new password";

  var icon = Icons.visibility;

  @override
  Widget build(BuildContext context) {
    return Card(
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
            onChanged: (val){
              setState(() {
                widget.value = val ;
              });
            },
            controller: widget.controller,
            validator: widget.validator,
            textInputAction: TextInputAction.next,
            obscureText: widget.isPassword,
            keyboardType: widget.inputType,
            maxLines: widget.isDescription ? null : 1,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(widget.pIcon),
              contentPadding: const EdgeInsets.all(10),
              labelText: widget.hintText,
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
              icon: Icon(
                icon,
                color: icon == Icons.visibility ? mainRed : Colors.grey,
              ),
              color: Colors.black26,
            ),
        ],
      ),
    );
  }
}

class SmallInputField extends StatelessWidget {
   SmallInputField({Key? key,this.controller,this.icon,this.label}) : super(key: key);
  TextEditingController? controller;
  IconData? icon;
  String? label;
  @override
  Widget build(BuildContext context) {
    return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    elevation: 6,
    child: TextFormField(
      controller: controller,
      // textInputAction: TextInputAction.next,
      //onSaved: (value) => controller!.text = value!,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: false,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(
          icon,
          color: mainRed,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 12,
        ),
      ),
    ),
  );
  }
}

