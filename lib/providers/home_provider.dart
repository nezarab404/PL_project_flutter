// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:programming_languages_project/models/product_model.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/end_points.dart';
import 'package:programming_languages_project/shared/network/dio_helper.dart';
import 'package:programming_languages_project/shared/status.dart';

class HomeProvider with ChangeNotifier {
  int bottomNavBarIndex = 0;
  bool desc = true;
  List<ProductModel> products = [];
  String? lastTitle;
  Status getProductsStatus = Status.init;

  void changeIndex(int index) {
    bottomNavBarIndex = index;
    notifyListeners();
  }

  void changeSort() {
    desc = !desc;
    getProducts(title: lastTitle);
    notifyListeners();
  }

  Future<void> getProducts({String? title = "remaining_days"}) {
    products = [];
    lastTitle = title;
    getProductsStatus = Status.loading;

    print(getProductsStatus);
    return DioHelper.getData(
            url: PRODUCTS, token: token, sort: title, desc: desc)
        .then((value) {
      if (value.statusCode == 200) {
        value.data["products"].forEach((product) {
          products.add(ProductModel.fromJson(product));
        });
        getProductsStatus = Status.success;
        print(getProductsStatus);

      } else {
        getProductsStatus = Status.failed;
        print(getProductsStatus);
      }
      print(getProductsStatus);
      notifyListeners();
    }).catchError((error) {
      getProductsStatus = Status.failed;
      notifyListeners();
    });
  }

  void addLike(int id) {
    int index = products.indexWhere((element) => element.id == id);
    if (!products[index].isLike!) {
      products[index].likes = products[index].likes! + 1;
      products[index].isLike = true;
    } else {
      products[index].likes = products[index].likes! - 1;
      products[index].isLike = false;
    }
    notifyListeners();
  }
}
