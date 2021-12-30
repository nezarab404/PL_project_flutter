// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:programming_languages_project/models/product_model.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/end_points.dart';
import 'package:programming_languages_project/shared/network/dio_helper.dart';
import 'package:programming_languages_project/shared/status.dart';

class MyProductsProvider with ChangeNotifier {
  List<ProductModel> products = [];
  Status myProductsStatus = Status.init;
  Status deleteStatus = Status.init;

  Future<void> getMyProducts() async {
    products = [];
    myProductsStatus = Status.loading;
    DioHelper.getData(url: MY_PRODUCTS, token: token).then((value) {
      if (value.statusCode == 200) {
        value.data['products'].forEach((product) {
          products.add(ProductModel.fromJson(product));
          myProductsStatus = Status.success;
          print(myProductsStatus);
        });
      } else {
        print(value.data);
        myProductsStatus = Status.failed;
        print(myProductsStatus);
      }
      notifyListeners();
    }).catchError((error) {
      print(error);
      myProductsStatus = Status.failed;
      notifyListeners();
    });
  }

  Future<void> deleteMyProduct(int productId) async {
    myProductsStatus = Status.loading;
    DioHelper.deleteData(url: PRODUCTS + '/$productId').then((value) {
      if (value.statusCode == 200) {
        deleteStatus = Status.success;
        getMyProducts();
        print(deleteStatus);
      } else {
        print(value.data);
        deleteStatus = Status.failed;
        print(deleteStatus);
      }
      notifyListeners();
    }).catchError((e) {
      print(e);
      deleteStatus = Status.failed;
      notifyListeners();
    });
  }
}
