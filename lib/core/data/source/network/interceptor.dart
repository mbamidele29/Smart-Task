import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_task/core/config/config.dart';

class HttpServiceInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer ${AppConfig.token}';
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(err.message);
    super.onError(err, handler);
  }
}
