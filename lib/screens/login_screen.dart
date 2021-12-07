// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../shared/commponents/input_form.dart';
import '../shared/commponents/header.dart';
import '../shared/themes/main_theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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

                //Logo
                Positioned(
                  top: screenHeight / 10,
                  left: screenWidth / 3.7,
                  child: SvgPicture.asset(
                    'assets/images/cart_red2.svg',
                  ),
                ),

                //Login Text
                Container(
                  height: screenHeight / 2.4,
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Login",
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
              height: screenHeight / 15,
            ),
            //Login Form
            InputForm(
              screenWidth: screenWidth,
              screenName: "LoginScreen",
              hintText: "Email or Username",
            ),
            SizedBox(
              height: screenHeight / 40,
            ),
            InputForm(
              screenWidth: screenWidth,
              screenName: "LoginScreen",
              hintText: "Password",
            ),
            //Help Text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Forgot password?",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("ٌReset"),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight / 15,
            ),
            SizedBox(
              height: screenHeight / 10,
              width: screenHeight / 10,
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: mainRed,
                child: Icon(
                  Icons.arrow_forward,
                  color: mainDarkBlue,
                ),
                elevation: 6,
              ),
            ),
            SizedBox(
              height: screenHeight / 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("Create one now!"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
