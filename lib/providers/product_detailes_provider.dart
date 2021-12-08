import 'package:flutter/material.dart';

class ProductDetailesProvider with ChangeNotifier {
  int carouselIndex =0;

  void changeCarouselIndex(int index) {
    carouselIndex = index;
    notifyListeners();
  }

}