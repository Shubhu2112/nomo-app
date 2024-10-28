// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nomo_app/core/data/constant/api_constants.dart';
import 'package:nomo_app/core/data/enums/api_type.enum.dart';
import 'package:nomo_app/core/services/cookie_services/cookie.service.dart';
// import 'package:torus/core/constant/api_constants.dart';

class Request {
  static Dio createApiClient(
      {bool isPublic = true,
      Function({required String message})? onError,
      ApiType? type}) {
    final BaseOptions networkOptions = ApiConstants(type).networkOptions;
    Dio dio = Dio(networkOptions);
    print(dio.options.baseUrl);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (!isPublic) {
          String? accessToken = await CookieService.retrieveData('token');
          options.headers['authorization'] = 'Bearer $accessToken';
        }

        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Do something with response data
        return handler.next(response);
      },
      onError: (e, handler) {
        Fluttertoast.showToast(
            msg: e.response?.data["message"] ?? "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 10,
            textColor: Colors.white,
            backgroundColor: Colors.red,
            fontSize: 16.0);
        // You can customize the error handling based on the DioExceptionType
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          // Handle timeout errors
          if (kDebugMode) {
            print('Request Timeout: $e');
          }
        } else if (e.type == DioExceptionType.badResponse) {
          // Handle non-2xx HTTP response errors
          if (kDebugMode) {
            print('HTTP Error Response: $e');
          }
        } else {
          // Handle other DioExceptionType
          if (kDebugMode) {
            print('Dio Error: $e');
          }
        }
        // Do something with response error
        if (onError != null) {
          onError(message: "");
        }

        return handler.reject(e);
      },
    ));

    return dio;
  }
}
