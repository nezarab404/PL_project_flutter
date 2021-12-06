// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:programming_languages_project/shared/commponents/input_form.dart';

import '../shared/commponents/header.dart';
import '../shared/themes/main_theme.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              //Header Shadow
              Header(
                height: screenHeight / 2.4,
                color: Colors.black26,
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
              Header(
                height: screenHeight / 2.45,
                color: darkBlue2,
              ),
              //Register user icon
              Positioned(
                top: 60,
                left: 120,
                child: Image.asset(
                  'assets/images/register.png',
                  scale: 3,
                  color: mainRed,
                ),
              ),
              //Register Text
              Container(
                height: screenHeight / 2.4,
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Register",
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
          //Register Form
          InputForm(
            screenWidth: screenWidth,
            hintText: "Username",
          ),
          SizedBox(
            height: screenHeight / 40,
          ),
          InputForm(
            screenWidth: screenWidth,
            hintText: "Email",
          ),
          SizedBox(
            height: screenHeight / 40,
          ),
          InputForm(
            screenWidth: screenWidth,
            hintText: "Password",
          ),
          SizedBox(
            height: screenHeight / 40,
          ),
          InputForm(
            screenWidth: screenWidth,
            hintText: "Confirm password",
          ),

          SizedBox(
            height: screenHeight / 15,
          ),
          SizedBox(
            height: 80,
            width: 80,
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
        ],
      ),
    );
  }
}
