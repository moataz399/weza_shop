// @dart=2.9

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:weza_shop/shared/constant.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ));
  }

  static Future<Response> getData (
      {@required String url,  Map<String, dynamic> query,String token}) async {

    dio.options.headers= {
      'Content-Type': 'application/json',
      'Authorization': token ?? "" ,
      'lang': 'en',
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {@required String url,
      Map<String, dynamic> query,
      @required Map<String, dynamic> data,String token})async {
    dio.options.headers= {
      'Content-Type': 'application/json',
      'Authorization': token ?? "" ,
      'lang': 'en',
    };
    return  dio.post(url, queryParameters: query, data: data);
  }






  static Future<Response> putData(
      {@required String url,
        Map<String, dynamic> query,
        @required Map<String, dynamic> data,
        String token})async {
    dio.options.headers= {
      'Content-Type': 'application/json',
      'Authorization': token ?? "" ,
      'lang': 'en',
    };
    return  dio.put(url, queryParameters: query, data: data);
  }




}
