import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:test_2/helper/catch_exceptions.dart';

class DioSettings {
  static const mainServer = 'https://test-docs.stores.kg/api/';

  Dio dio = Dio(BaseOptions(
    baseUrl: mainServer, 
    connectTimeout: 10000,
    receiveTimeout: 10000,
  ));

  initialSettings() {
    Interceptors interceptors = dio.interceptors;
    interceptors.requestLock.lock();
    interceptors.clear();
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      debugPrint('REQUEST[${options.data}] => PATH: ${options.path}');
      return handler.next(options);
    }, onResponse: (response, handler) {
      debugPrint(
          'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
      return handler.next(response);
    }, onError: (DioError e, handler) {
      debugPrint(
          'ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
      CatchException.convertException(e);
      return handler.next(e);
    }));
    interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ));
    interceptors.requestLock.unlock();
  }

  DioSettings() {
    initialSettings();
  }
}
