import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:programming_languages_project/providers/verify_provider.dart';
import 'package:programming_languages_project/screens/drawer.dart';
import 'package:programming_languages_project/shared/status.dart';
import 'package:programming_languages_project/shared/validator.dart';
import 'package:provider/provider.dart';

import '../shared/themes/main_theme.dart';
import '../shared/commponents/header.dart';

class ForgotPasswordScreen extends StatefulWidget {
  bool passwordState = true;


  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  IconData? icon = Icons.visibility;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var password = TextEditingController();
    var confirmPassword = TextEditingController();
    var provider = Provider.of<VerifyProvider>(context);
    String x1="",x2="";
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
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 6,
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth / 10,
              ),
              child: TextFormField(
                controller: password,
                //validator: (val)=>Validator.passwordValidator(val),
                textInputAction: TextInputAction.next,
                obscureText: true,
                maxLines: 1,
                decoration:  InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      widget.passwordState = !widget.passwordState;
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
                  contentPadding: const EdgeInsets.all(10),
                  labelText: "New password",
                ),
              ),
            ),
            //Reset Form
            // InputForm(
            //   screenWidth: screenWidth,
            //   hintText: "New password",
            //   pIcon: Icons.password,
            //   isPassword: true,
            //   validator: (val) => Validator.passwordValidator(val),
            //   // controller: password,
            //   value: x1,
            //
            // ),
            SizedBox(
              height: screenHeight / 40,
            ),
            Card(
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
                  TextFormField(
                    controller: confirmPassword,
                    validator: (val)=>Validator.passwordValidator(val),
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.check_circle),
                      contentPadding: EdgeInsets.all(10),
                      labelText: "Confirm new password",
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.passwordState = !widget.passwordState;
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
            ),
            // InputForm(
            //   screenWidth: screenWidth,
            //   hintText: "Confirm new password",
            //   pIcon: Icons.check_circle,
            //   isPassword: true,
            //   validator: (val) => Validator.passwordValidator(val),
            //   // controller: confirmPassword,
            //   value: x2,
            // ),
            SizedBox(
              height: screenHeight / 10,
            ),
            SizedBox(
              height: screenHeight / 10,
              width: screenHeight / 10,
              child: FloatingActionButton(
                onPressed: () {
                  Provider.of<VerifyProvider>(context, listen: false)
                      .resetPassword(
                          password: password.text,
                          confirmPassword: confirmPassword.text)
                      .then((value) {
                    if (provider.s == Status.success) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => const MyDrawer()));
                    }
                    else{
                      print("erooooor");
                    }
                  });
                },
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
