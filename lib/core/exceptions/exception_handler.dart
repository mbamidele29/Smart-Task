import 'package:dio/dio.dart';
import 'package:smart_task/core/data/models/error.dart';
import 'package:smart_task/generated/l10n.dart';

import 'server_exception.dart';

final String errorDefaultMessage = S.current.anErrorOccurred;

String exceptionHandler(Exception error, {String? errorMessage}) {
  if (errorMessage != null) return errorMessage;
  if (error is ServerException) return errorDefaultMessage;
  if (error is NetworkException) return error.message;

  if (error is DioException) {
    if (error.response?.data is String) return error.response?.data;
    switch (error.type) {
      case DioExceptionType.badResponse:
        if (error.response != null) {
          if (error.response?.statusCode == 401) {
            return 'user unauthorised';
          } else if (error.response?.statusCode == 403) {
            return 'Session expired';
          } else if (error.response?.statusCode == 500) {
            return errorDefaultMessage;
          }
        }
        return error.message ?? errorDefaultMessage;

      case DioExceptionType.connectionTimeout:
        return S.current.connectionTimedout;
      case DioExceptionType.sendTimeout:
        return S.current.connectionTimedout;
      case DioExceptionType.receiveTimeout:
        return S.current.connectionTimedout;
      case DioExceptionType.cancel:
        return "Request cancelled";
      case DioExceptionType.unknown:
        return "No Internet Connection";

      default:
        return errorDefaultMessage;
    }
  }
  return errorDefaultMessage;
}
