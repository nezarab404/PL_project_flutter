// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:programming_languages_project/providers/verify_provider.dart';
import 'package:programming_languages_project/screens/optional_user_info_screen.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/status.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../shared/themes/main_theme.dart';
import '../shared/commponents/header.dart';
import 'forgot_password_screen.dart';

// ignore: must_be_immutable
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

  final _formKey = GlobalKey<FormState>();
  final _code = TextEditingController();

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  Timer? timer;
  int _start = 60;
  bool isStart = false;
  void startTimer() {
    _start = 60;
    isStart = true;
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            isStart = false;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var lan = AppLocalizations.of(context)!;

    // ..text = "123456";

    // ignore: close_sinks
    StreamController<ErrorAnimationType>? errorController;

    //bool hasError = false;
    String currentText = "";

    // @override
    // void initState() {
    //   errorController = StreamController<ErrorAnimationType>();
    //   super.initState();
    // }

    // @override
    // void dispose() {
    //   errorController!.close();

    //   super.dispose();
    // }

    var provider = Provider.of<VerifyProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: widget._formKey,
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
                    child: Text(
                      lan.verify,
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
                  lan.verifyMsg,
                  style: TextStyle(
                    fontSize: 16,
                    color: theme.textTheme.bodyText1!.color,
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
                controller: widget._code,
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
                  inactiveColor: theme == darkTheme ? Colors.white : mainGrey,
                  inactiveFillColor:
                      theme == darkTheme ? Colors.white : mainGrey,
                  activeColor: theme == darkTheme ? Colors.white : mainGrey,
                  activeFillColor:
                      theme == darkTheme ? Colors.white : mainGrey,
                  selectedColor: theme == darkTheme ? Colors.white : mainGrey,
                  selectedFillColor:
                      theme == darkTheme ? Colors.white : mainGrey,
                ),
                enableActiveFill: true,
                errorAnimationController: errorController,
                onCompleted: (v) {
                  print("Completed");
                  widget._code.text = v;
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
                onPressed: isStart
                    ? null
                    : () {
                        Provider.of<VerifyProvider>(context, listen: false)
                            .resendCode();
                        startTimer();
                      },
                child: Text(
                  isStart ? "$_start" : lan.resendCode,
                  style: TextStyle(
                    color: mainRed,
                    fontSize: 22,
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
                  onPressed: () async {
                    widget._isReset
                        ? await Provider.of<VerifyProvider>(context,
                                listen: false)
                            .resetVerify(
                                email: widget.email!, code: widget._code.text)
                            .then((value) {
                            print("koo ${widget.email!}");
                            print(widget._code.text);
                            if (provider.s == Status.loading) {
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
                              print(widget._code.text);
                              //  print(value);
                              //  print(value);
                              print("error");
                            }
                          })
                        : Provider.of<VerifyProvider>(context, listen: false)
                            .registerVerify(code: widget._code.text)
                            .then((value) {
                            if (value) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => OptionalUserInfoScreen(),
                                ),
                              );
                            } else {
                              print("error");
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
      ),
    );
  }
}
