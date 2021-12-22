// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:programming_languages_project/models/product_model.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/end_points.dart';
import 'package:programming_languages_project/shared/network/dio_helper.dart';
import 'package:programming_languages_project/shared/status.dart';

class ProductILikeProvider with ChangeNotifier {
  List<ProductModel> products = [];
  Status productILikeStatus = Status.init;

  Future<void> getLikedProducts() async {
    products = [];
    productILikeStatus = Status.loading;
    DioHelper.getData(url: LIKED_PRODUCTS, token: token).then((value) {
      if (value.statusCode == 200) {
        value.data['products'].forEach((product) {
          products.add(ProductModel.fromJson(product));
          productILikeStatus = Status.success;
          print(productILikeStatus);
        });
      } else {
        print(value.data);
        productILikeStatus = Status.failed;
        print(productILikeStatus);
      }
      notifyListeners();
    }).catchError((error) {
      print(error);
      productILikeStatus = Status.failed;
      notifyListeners();
    });
  }
}
