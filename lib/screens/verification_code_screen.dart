import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:programming_languages_project/providers/verify_provider.dart';
import 'package:provider/provider.dart';

import '../shared/commponents/input_form.dart';
import '../shared/themes/main_theme.dart';
import '../shared/commponents/header.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({Key? key}) : super(key: key);

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    final _formKey = GlobalKey<FormState>();
    final _code1 = TextEditingController();
    final _code2 = TextEditingController();
    final _code3 = TextEditingController();
    final _code4 = TextEditingController();
    final _code5 = TextEditingController();
    final _code6 = TextEditingController();
    var provider = Provider.of<VerifyProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
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
                    top: screenHeight / 20,
                    left: screenWidth / 4.3,
                    child: SvgPicture.asset(
                      'assets/images/validation.svg',
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
                      "Verify",
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
                  "Please check your inbox for the 6-digit code that has been sent to your email address",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: screenHeight / 15,
              ),
              //Verify Form
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputForm(
                      screenWidth: screenWidth,
                      screenName: "VerificationCodeScreen",
                      controller: _code1,
                    ),
                    InputForm(
                      screenWidth: screenWidth,
                      screenName: "VerificationCodeScreen",
                      controller: _code2,
                    ),
                    InputForm(
                      screenWidth: screenWidth,
                      screenName: "VerificationCodeScreen",
                      controller: _code3,
                    ),
                    InputForm(
                      screenWidth: screenWidth,
                      screenName: "VerificationCodeScreen",
                      controller: _code4,
                    ),
                    InputForm(
                      screenWidth: screenWidth,
                      screenName: "VerificationCodeScreen",
                      controller: _code5,
                    ),
                    InputForm(
                      screenWidth: screenWidth,
                      screenName: "VerificationCodeScreen",
                      controller: _code6,
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Resend code",
                  style: TextStyle(
                    color: mainRed,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight / 10,
              ),
              SizedBox(
                height: screenHeight / 10,
                width: screenHeight / 10,
                child: FloatingActionButton(
                  onPressed: () {
                    String code = _code1.text +
                        _code2.text +
                        _code3.text +
                        _code4.text +
                        _code5.text +
                        _code6.text;
                    Provider.of<VerifyProvider>(context, listen: false)
                        .registerVerify(code: code)
                        .then((value) {
                      print("kokokokokk");
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
      ),
    );
  }
}
