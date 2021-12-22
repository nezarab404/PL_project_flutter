// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:programming_languages_project/providers/home_provider.dart';
import 'package:programming_languages_project/providers/network_provider.dart';
import 'package:programming_languages_project/screens/register_screen.dart';
import 'package:programming_languages_project/shared/end_points.dart';
import 'package:programming_languages_project/shared/keys.dart';
import 'package:programming_languages_project/shared/network/dio_helper.dart';
import 'package:programming_languages_project/shared/status.dart';
import 'package:programming_languages_project/shared/storage/shared_helper.dart';
import 'package:programming_languages_project/shared/validator.dart';
import 'package:provider/provider.dart';

import '../shared/commponents/input_form.dart';
import '../shared/commponents/header.dart';
import '../shared/themes/main_theme.dart';
import 'drawer.dart';
import 'verification_code_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var provider = Provider.of<NetworkProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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

              InputForm(
                controller: _email,
                screenWidth: screenWidth,
                hintText: "Email or Username",
                pIcon: Icons.email,
                validator: (val) => Validator.emailValidator(val),
                inputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: screenHeight / 40,
              ),
              InputForm(
                controller: _password,
                screenWidth: screenWidth,
                hintText: "Password",
                pIcon: Icons.password,
                validator: (val) => Validator.passwordValidator(val),
                isPassword: true,
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
                    onPressed: () async {
                      if (_email.text.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                },
                                child: Text(
                                  'Close',
                                ),
                              ),
                            ],
                            content: Text(
                              'Enter email first!',
                            ),
                          ),
                        );
                      } else if (Validator.emailValidator(_email.text) !=
                          null) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                },
                                child: Text(
                                  'Close',
                                ),
                              ),
                            ],
                            content: Text(
                              'Enter valid email address',
                            ),
                          ),
                        );
                      } else {
                        await DioHelper.postData(
                            url: SEND_PASSWORD_VERIVY_EMAIL,
                            data: {"email": _email.text}).then((value) {
                          if (value.statusCode == 200) {
                            return Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        VerificationCodeScreen.reset(
                                            email: _email.text)));
                          } else {
                            print(value.data["msg"]);
                          }
                        });
                      }
                    },
                    child: Text("ٌReset"),
                  ),
                ],
              ),
              SizedBox(height: screenHeight / 15),
              SizedBox(
                height: screenHeight / 10,
                width: screenHeight / 10,
                child: FloatingActionButton(
                  onPressed: () async {
                    //TODO: login
                    if (_formKey.currentState!.validate()) {
                      Provider.of<NetworkProvider>(context, listen: false)
                          .userLogin(
                              email: _email.text, password: _password.text)
                          .then((value) {
                        if (provider.loggedInStatus == AuthStatus.loggedIn) {
                          SharedHelper.saveData(
                                  key: TOKEN,
                                  value: provider.loginModel!.user!.token)
                              .then((value) {
                            if (provider
                                    .loginModel!.user!.accountConfirmation ==
                                0) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          VerificationCodeScreen()));
                            } else {
                              Provider.of<HomeProvider>(context, listen: false)
                                  .getProducts();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const MyDrawer()));
                            }
                          }).catchError((error) {});
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(provider.msg),
                            backgroundColor: mainRed,
                          ));
                        }
                      }).catchError((error) {});
                    }
                  },
                  backgroundColor: mainRed,
                  child: Icon(
                    Icons.arrow_forward,
                    color: mainDarkBlue,
                  ),
                  elevation: 6,
                ),
              ),
              SizedBox(
                height: screenHeight / 10 - 30,
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
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => RegisterScreen()));
                    },
                    child: Text("Create one now!"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
