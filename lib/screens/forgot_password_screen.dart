import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:programming_languages_project/shared/validator.dart';

import '../shared/commponents/input_form.dart';
import '../shared/themes/main_theme.dart';
import '../shared/commponents/header.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                //Header Shadow
                Header(
                  height: screenHeight / 2.4,
                  color: Colors.black26,
                ),
                Header(
                  height: screenHeight / 2.45,
                  color: darkBlue2,
                ),
                //Main Header
                //Color Gradient for Header
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     colors: [
                //       Color(0xff63657D),
                //       Color(0xffd3d3d3),
                //     ],
                //     begin: Alignment.topCenter,
                //     end: Alignment.bottomCenter,

                //Register user icon
                Positioned(
                  top: screenHeight / 15,
                  left: screenWidth / 4.3,
                  child: SvgPicture.asset(
                    'assets/images/password_reset.svg',
                    color: mainRed,
                    height: screenHeight / 4,
                    width: screenWidth / 2,
                  ),
                ),

                //Verify Text
                Container(
                  height: screenHeight / 2.4,
                  alignment: Alignment.bottomCenter,
                  child: const Text(
                    "Reset",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 42,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight / 20,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: const Text(
                "Enter your new password below:",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: screenHeight / 40,
            ),
            //Reset Form
            InputForm(
              screenWidth: screenWidth,
              hintText: "New password",
              pIcon: Icons.password,
              validator: (val)=>Validator.passwordValidator(val),
            ),
            SizedBox(
              height: screenHeight / 40,
            ),
            InputForm(
              screenWidth: screenWidth,
              hintText: "Confirm new password",
              pIcon: Icons.check_circle,
              validator: (val)=>Validator.passwordValidator(val),
            ),
            SizedBox(
              height: screenHeight / 10,
            ),
            SizedBox(
              height: screenHeight / 10,
              width: screenHeight / 10,
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: mainRed,
                child: Icon(
                  Icons.check,
                  color: mainDarkBlue,
                  size: 40,
                ),
                elevation: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
