import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CatchException {
  String? massage;

  CatchException({this.massage});

  static CatchException convertException(dynamic error) {
    if (error is DioError && error.error is CatchException) {
      return error.error;
    }
    if (error is DioError) {
      debugPrint(error.toString());
      if (error.type == DioErrorType.connectTimeout) {
        debugPrint('CONNECTION_ERROR');
        return CatchException(
            massage: 'Привышено время обработки зароса. Повторите позднее');
      } else if (error.type == DioErrorType.receiveTimeout) {
        debugPrint('RECEIVE_ERROR');
        return CatchException(
            massage: 'Привышено время обработки зароса. Повторите позднее');
      } else if (error.response == null) {
        debugPrint('NO_INTERNET');
        return CatchException(massage: 'Нет соеденения с интернетом');
      } else if (error.response!.statusCode == 401) {
        debugPrint('401 - AUTH ERROR');
        return CatchException(massage: 'Ошибка обнавления токена');
      } else if (error.response!.statusCode == 409) {
        debugPrint('409 - AUTH ERROR');
        return CatchException(massage: error.response!.data['message']);
      } else {
        return CatchException(massage: 'Произошла системная ошибка');
      }
    }
    if (error is CatchException) {
      return error;
    }else {
      return CatchException(massage: 'Произошла системная ошибка');
    }
  }
}
