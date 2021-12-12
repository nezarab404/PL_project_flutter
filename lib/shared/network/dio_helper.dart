import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: "http://192.168.137.250:8000/api/", //TODO
          receiveDataWhenStatusError: true,
          headers: {"Content-Type": "application/json"}),
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      'auth-token': "$token"
    };
    Response response;
    try {
      response = await dio.post(
        url,
        data: data,
        queryParameters: query,
      );
    } on DioError catch (e) {
      return e.response!;
    }
    return response;
  }

  static Future<Response> getData(
      {required String url,
      Map<String, dynamic>? query,
      String lang = 'en',
      String? token}) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      'lang': lang,
      'auth-token': "$token"
    };
    return await dio.get(url);
  }

  static Future<Response> deleteData(
      {required String url, required int id}) async {
    return dio.delete(url, queryParameters: {"id": id});
  }

  static Future<Response> updateData(
      {required String url,
      Map<String, dynamic>? query,
      dynamic data,
      String? token}) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      "auth-token": "$token"
    };
    return dio.put(url, queryParameters: query, data: data);
  }

  static Future<Response> uploadFile(
      {required String url,
      Map<String, dynamic>? query,
      required XFile file,
      String? token}) async {
    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path,
          filename: file.path.split('/').last)
    });

    return dio.post(url, data: data);
  }

  Future<Response> uploadMultiFiles(
      {required String url,
      Map<String, dynamic>? query,
      required List<XFile> files,
      String? token}) async {
    FormData data = FormData();
    for (int i = 0; i < files.length; i++) {
      data.files.addAll(
        [
          MapEntry(
            'image${i+1}',
            await MultipartFile.fromFile(
              files[i].path,
              filename: files[i].path.split('/').last
            ),
          ),
        ],
      );
    }
     dio.options.headers = {
      "Content-Type": "application/json",
      "auth-token": "$token"
    };
    return dio.post(url,data: data);
  }
}
