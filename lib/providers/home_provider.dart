import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  int bottomNavBarIndex = 0;

   void changeIndex(int index) {
    bottomNavBarIndex = index;
    notifyListeners();
  }
  
}
