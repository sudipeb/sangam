import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

///Logs requests and responses using [Interceptor] with [Dio]
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint(" ${options.method} ${options.uri}");
    debugPrint("Headers: ${options.headers}");
    debugPrint("Body: ${options.data}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("⬅ ${response.statusCode} ${response.requestOptions.uri}");
    debugPrint("Response: ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(" ${err.response?.statusCode} ${err.requestOptions.uri}");
    super.onError(err, handler);
  }
}
