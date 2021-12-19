import 'package:flutter/material.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/network/dio_helper.dart';

class ProductDetailesProvider with ChangeNotifier {
  int carouselIndex = 0;

  void changeCarouselIndex(int index) {
    carouselIndex = index;
    notifyListeners();
  }

  Future<void> like(int id) async {
    await DioHelper.getData(token: token,url: "/products/like/$id")
        .then((value) {
          print(value);
          notifyListeners();
    })
        .catchError((e) {});
    notifyListeners();
  }

}
