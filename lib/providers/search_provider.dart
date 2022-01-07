import 'package:flutter/material.dart';
import 'package:programming_languages_project/models/product_model.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/end_points.dart';
import 'package:programming_languages_project/shared/network/dio_helper.dart';
import 'package:programming_languages_project/shared/status.dart';

class SearchProvider with ChangeNotifier {
  List<ProductModel> result = [];
  Status searchStatus = Status.init;
  String? searchBy;
  setCategory(String val) {
    searchBy = val;
    notifyListeners();
  }

  void searchByName(String text) {
    searchStatus = Status.loading;
    result = [];
    notifyListeners();
    DioHelper.postData(url: SEARCH_BY_NAME, token: token, data: {"name": text})
        .then((value) {
      if (value.statusCode == 200) {
        value.data['products'].forEach((product) {
          result.add(ProductModel.fromJson(product));
        });
        searchStatus = Status.success;
      } else {
        searchStatus = Status.failed;
      }
      notifyListeners();
    });
  }

  void searchByDate(DateTime date) {
    searchStatus = Status.loading;
    result = [];
    notifyListeners();
    DioHelper.postData(
        url: SEARCH_BY_DATE,
        token: token,
        data: {"date": "${date.year}-${date.month}-${date.day}"}).then((value) {
      if (value.statusCode == 200) {
        value.data['products'].forEach((product) {
          result.add(ProductModel.fromJson(product));
        });
        searchStatus = Status.success;
      } else {
        searchStatus = Status.failed;
      }
      notifyListeners();
    }).catchError((e) {
      searchStatus = Status.failed;
    });
  }
}
