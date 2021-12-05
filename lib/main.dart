import 'package:flutter/material.dart';
import 'package:programming_languages_project/providers/network_provider.dart';
import 'package:programming_languages_project/screens/home_screen.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';
import 'package:provider/provider.dart';

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
        home: const HomeScreen(),
      ),
    );
  }
}
