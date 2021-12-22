import 'package:flutter/material.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';

// ignore: must_be_immutable
class DiscountsInputField extends StatelessWidget {
  DiscountsInputField({Key? key, this.cardColor,this.controller}) : super(key: key);
  Color? cardColor;
  TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 6,
      child: TextFormField(
        controller: controller,
        cursorColor: cardColor == mainRed ? Colors.white : mainRed,
        style: TextStyle(
          color: cardColor == mainRed ? Colors.white : Colors.black,
        ),
        textAlign: TextAlign.center,
        maxLength: 2,
        textInputAction: TextInputAction.next,
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
          signed: false,
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: 5,
          ),
        ),
      ),
    );
  }
}
