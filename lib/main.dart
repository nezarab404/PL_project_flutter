import 'package:flutter/material.dart';
import 'package:programming_languages_project/screens/forgot_password_screen.dart';
import 'package:programming_languages_project/screens/login_screen.dart';
import 'package:programming_languages_project/screens/register_screen.dart';
import 'package:programming_languages_project/screens/verification_code_screen.dart';
import 'package:provider/provider.dart';

import '../providers/network_provider.dart';
import '../shared/themes/main_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NetworkProvider>(
            create: (_) => NetworkProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          primarySwatch: mainRed,
        ),
        darkTheme: ThemeData(
          primarySwatch: mainRed,
          backgroundColor: mainDarkBlue,
          scaffoldBackgroundColor: mainDarkBlue,
        ),
        home: const VerificationCodeScreen(),
      ),
    );
  }
}
