// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:programming_languages_project/providers/verify_provider.dart';
import 'package:programming_languages_project/screens/drawer.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/status.dart';
import 'package:programming_languages_project/shared/validator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../shared/themes/main_theme.dart';
import '../shared/commponents/header.dart';

// ignore: must_be_immutable
class ForgotPasswordScreen extends StatefulWidget {
  bool passwordState = true;
  var password = TextEditingController();
  var confirmPassword = TextEditingController();

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
    var lan = AppLocalizations.of(context)!;
    var provider = Provider.of<VerifyProvider>(context);
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
                  child: Text(
                    lan.reset,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyText1!.color,
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
              child: Text(
                lan.enterYourNewPasswordBelow,
                style:  TextStyle(
                  fontSize: 16,
                  color: theme.textTheme.bodyText1!.color,
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
                controller: widget.password,
                //validator: (val)=>Validator.passwordValidator(val),
                textInputAction: TextInputAction.next,
                obscureText: true,
                maxLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: const Icon(LineIcons.lock),
                  suffixIcon: IconButton(
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
                  labelText: lan.newPassword,
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
                    controller: widget.confirmPassword,
                    validator: (val) => Validator.passwordValidator(val),
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.check_circle),
                      contentPadding: const EdgeInsets.all(10),
                      labelText: lan.confirmNewPassword,
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
                          password: widget.password.text,
                          confirmPassword: widget.confirmPassword.text)
                      .then((value) {
                    if (provider.s == Status.success) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => const MyDrawer()));
                    } else {
                      print("erooooor");
                    }
                  });
                },
                backgroundColor: mainRed,
                child: Icon(
                  Icons.check,
                  color: theme.backgroundColor,
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
