// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';

class InputForm extends StatefulWidget {
  final double? screenWidth;
  final String? hintText;
  final String? hintText2;
  final IconData? pIcon;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final String? Function(String?)? validator;
  final void Function(String?)? saveFunction;
  bool isPassword;
  bool isDescription;

  InputForm({
    this.screenWidth,
    this.controller,
    this.hintText,
    this.pIcon,
    this.inputType,
    this.validator,
    this.isPassword = false,
    this.isDescription = false,
    this.hintText2,
    this.saveFunction,
  });

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  var icon = Icons.visibility;

  bool visibility = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 6,
      margin: EdgeInsets.symmetric(
        horizontal: widget.screenWidth != null ? widget.screenWidth! / 10 : 0,
      ),
      child: TextFormField(
        onSaved: widget.saveFunction,
        controller: widget.controller,
        validator: widget.validator,
        textInputAction: TextInputAction.next,
        obscureText: visibility,
        keyboardType: widget.inputType,
        maxLines: widget.isDescription ? null : 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      visibility = !visibility;
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
                )
              : null,
          prefixIcon: Icon(widget.pIcon),
          contentPadding: const EdgeInsets.all(10),
          labelText: widget.hintText,
          hintText: widget.hintText2,
        ),
      ),
    );
  }
}

class SmallInputField extends StatelessWidget {
  SmallInputField({Key? key, this.controller, this.icon, this.label})
      : super(key: key);
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
