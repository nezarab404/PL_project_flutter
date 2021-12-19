import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:programming_languages_project/providers/verify_provider.dart';
import 'package:programming_languages_project/shared/status.dart';
import 'package:provider/provider.dart';

import '../shared/themes/main_theme.dart';
import '../shared/commponents/header.dart';
import 'drawer.dart';
import 'forgot_password_screen.dart';

class VerificationCodeScreen extends StatefulWidget {
  VerificationCodeScreen({Key? key}) : super(key: key) {
    _isReset = false;
  }

  VerificationCodeScreen.reset({Key? key, required this.email})
      : super(key: key) {
    _isReset = true;
  }

  String? email;
  bool _isReset = false;

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    TextEditingController textEditingController = TextEditingController();
    // ..text = "123456";

    // ignore: close_sinks
    StreamController<ErrorAnimationType>? errorController;

    bool hasError = false;
    String currentText = "";

    @override
    void initState() {
      errorController = StreamController<ErrorAnimationType>();
      super.initState();
    }

    @override
    void dispose() {
      errorController!.close();

      super.dispose();
    }

    final _formKey = GlobalKey<FormState>();
    final _code = TextEditingController();

    var provider = Provider.of<VerifyProvider>(context);

    final focusNode1 = FocusNode();
    final focusNode2 = FocusNode();
    final focusNode3 = FocusNode();
    final focusNode4 = FocusNode();
    final focusNode5 = FocusNode();
    final focusNode6 = FocusNode();

    final List<FocusNode> node = [
      focusNode1,
      focusNode2,
      focusNode3,
      focusNode4,
      focusNode5,
      focusNode6,
    ];

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
              PinCodeTextField(
                appContext: context,
                cursorColor: mainRed,
                controller: _code,
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: mainRed,
                ),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                length: 6,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(15),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  inactiveColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  activeColor: Colors.white,
                  activeFillColor: Colors.white,
                  selectedColor: Colors.white,
                  selectedFillColor: Colors.white,
                ),
                enableActiveFill: true,
                errorAnimationController: errorController,
                onCompleted: (v) {
                  print("Completed");
                  _code.text = v;
                },
                // onTap: () {
                //   print("Pressed");
                // },
                onChanged: (value) {
                  print(value);
                  setState(() {
                    currentText = value;
                  });
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              ),

              TextButton(
                onPressed: () {
                  Provider.of<VerifyProvider>(context, listen: false)
                      .resendCode();
                },
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
                  onPressed: () async{
                    widget._isReset
                        ? await Provider.of<VerifyProvider>(context, listen: false)
                            .resetVerify(email: widget.email!, code: _code.text)
                            .then((value) {
                              print("koo ${widget.email!}");
                              print(_code.text);
                            if(provider.s == Status.loading){
                              print(provider.s);
                            }
                              if (provider.s == Status.success) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          ForgotPasswordScreen()));
                            } else {
                              print("moo ${widget.email!}");
                              print(_code.text);
                            //  print(value);
                              print("error");
                            }
                          })
                        : Provider.of<VerifyProvider>(context, listen: false)
                            .registerVerify(code: _code.text)
                            .then((value) {
                            if (value) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const MyDrawer()));
                            } else {
                              print("error");
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
      ),
    );
  }
}
