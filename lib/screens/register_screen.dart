// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:programming_languages_project/providers/network_provider.dart';
import 'package:programming_languages_project/screens/verification_code_screen.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/keys.dart';
import 'package:programming_languages_project/shared/status.dart';
import 'package:programming_languages_project/shared/storage/shared_helper.dart';
import 'package:programming_languages_project/shared/validator.dart';
import 'package:provider/provider.dart';

import '../shared/commponents/input_form.dart';
import '../shared/commponents/header.dart';
import '../shared/themes/main_theme.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var provider = Provider.of<NetworkProvider>(context);
    var screenHeight = MediaQuery.of(context).size.height;

    var lan = AppLocalizations.of(context)!;
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
                    top: screenHeight / 10,
                    left: screenWidth / 3.2,
                    child: SvgPicture.asset(
                      'assets/images/register.svg',
                      color: mainRed,
                    ),
                  ),

                  //Register Text
                  Container(
                    height: screenHeight / 2.4,
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      lan.register,
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
                hintText: lan.username,
                pIcon: Icons.person,
                controller: _name,
                inputType: TextInputType.name,
                validator: (val) => Validator.nameValidator(val),
              ),
              SizedBox(
                height: screenHeight / 40,
              ),
              InputForm(
                screenWidth: screenWidth,
                hintText: lan.email,
                pIcon: Icons.email,
                controller: _email,
                inputType: TextInputType.emailAddress,
                validator: (val) => Validator.emailValidator(val),
              ),
              SizedBox(
                height: screenHeight / 40,
              ),
              InputForm(
                screenWidth: screenWidth,
                hintText: lan.password,
                pIcon: Icons.password,
                controller: _password,
                isPassword: true,
                validator: (val) => Validator.passwordValidator(val),
              ),
              SizedBox(
                height: screenHeight / 40,
              ),
              InputForm(
                screenWidth: screenWidth,
                hintText: lan.confirmPassowrd,
                pIcon: Icons.check_circle,
                controller: _confirmPassword,
                isPassword: true,
                validator: (val) => Validator.passwordValidator(val),
              ),

              SizedBox(
                height: screenHeight / 20,
              ),
              SizedBox(
                height: screenHeight / 10,
                width: screenHeight / 10,
                child: provider.userStatus == AuthStatus.registering ? CircularProgressIndicator():FloatingActionButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await Provider.of<NetworkProvider>(context, listen: false)
                          .userRegister(
                        name: _name.text,
                        email: _email.text,
                        password: _password.text,
                        confirmPassword: _confirmPassword.text,
                      )
                          .then((value) {
                        print("koko :${provider.userStatus}");
                        if (provider.userStatus == AuthStatus.registered) {
                          print("success");

                          SharedHelper.saveData(
                                  key: TOKEN,
                                  value: provider.registerModel!.user!.token)
                              .then((value) {
                            token = provider.registerModel!.user!.token;
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => VerificationCodeScreen()));
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(provider.Rmsg.toString())));
                        }
                      });
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
            ],
          ),
        ),
      ),
    );
  }
}
