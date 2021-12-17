import 'package:dio/dio.dart';

import 'package:test_2/helper/catch_exceptions.dart';
import 'package:test_2/helper/dio_settings.dart';
import 'package:test_2/logic/model/category.dart';

class Provider {
  late DioSettings _dioSettings;
  late Dio _dio;

  static final Provider _instance = Provider.internal();
  factory Provider() => _instance;
  Provider.internal() {
    _dioSettings = DioSettings();
    _dio = _dioSettings.dio;
  }

  Future<Category> getStores() async {
    try {
      final response = await _dio.get('categories');
      return  categoryFromJson(response.data);


    } on DioError catch (e) {
      throw CatchException.convertException(e);
    }
  }
} 


