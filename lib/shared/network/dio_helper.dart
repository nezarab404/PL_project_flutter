import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: "",//TODO
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
    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> getData(
      {required String url,
      Map<String, dynamic>? query,
      String lang = 'en',
      String? token}) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      'lang': lang,
      'Authorization': "Bearer $token"
    };
    return await dio.get(url);
  }

  static Future<Response> deleteData({required String url,required int id}) async {
    return dio.delete(url,
      queryParameters: {
        "id":id
      }
    );
  }
  static Future<Response> updateData({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
      String? token
    }) async {
       dio.options.headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    return dio.put(
      url,
      queryParameters:query,
      data: data
    );
  }

  
}
