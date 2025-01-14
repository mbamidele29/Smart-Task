import 'package:dio/dio.dart';

class HttpService {
  final Dio client;

  static const int timeoutDuration = 1;

  HttpService(this.client);

  Future<Response> getRequest(String endpoint,
          {Map<String, dynamic>? queryParameters}) async =>
      client.get(endpoint, queryParameters: queryParameters);

  Future<Response> post(String endpoint,
          {Map? data, Map<String, dynamic>? queryParameters}) async =>
      client.post(endpoint, data: data, queryParameters: queryParameters);

  Future<Response> put(String endpoint,
          {Map? data, Map<String, dynamic>? queryParameters}) async =>
      client.put(endpoint, data: data, queryParameters: queryParameters);

  Future<Response> delete(String endpoint,
          {Map? data, Map<String, dynamic>? queryParameters}) =>
      client.delete(endpoint, data: data, queryParameters: queryParameters);

  Future<Response> patch(String endpoint,
          {Map? data, Map<String, dynamic>? queryParameters}) async =>
      client.patch(endpoint, data: data, queryParameters: queryParameters);
}

extension ResponseExt on Response {
  bool get isSuccessful => statusCode! >= 200 && statusCode! < 300;
}
