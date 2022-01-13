import 'package:flutter/material.dart';
import 'package:programming_languages_project/shared/commponents/restart_widget.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/storage/shared_helper.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData =
      SharedHelper.getData(key: 'theme') == 'dark' ? darkTheme : lightTheme;
  bool themeBool = SharedHelper.getData(key: 'theme') == 'light' ? true : false;

  getTheme() => _themeData;

  setTheme(BuildContext context, bool theme) {
    themeBool = theme;
    if (themeBool) {
      _themeData = lightTheme;
      SharedHelper.saveData(key: 'theme', value: 'light');
    } else {
      _themeData = darkTheme;
      SharedHelper.saveData(key: 'theme', value: 'dark');
    }
    RestartWidget.restartApp(context);
    notifyListeners();
  }
}
