import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sangam/core/constants/api_constants.dart';
import 'package:sangam/core/network/interceptors/auth_interceptors.dart';
import 'package:sangam/core/network/interceptors/logging_interceptors.dart';
import 'package:sangam/core/network/interceptors/retry_interceptors.dart';
import 'package:sangam/core/network/network_exceptions.dart';

class ApiClient {
  ///singleton of [ApiClient], ensures only one [ApiClient] exists in the app
  static final ApiClient _instance = ApiClient._internal();
  late final Dio dio;
  final storage = FlutterSecureStorage();
  factory ApiClient() => _instance;

  ///Private constructor _internal initializes the [Dio] object
  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );
    dio.interceptors.addAll([
      LoggingInterceptor(),
      AuthInterceptor(dio: dio),
      RetryOnConnectionChangeInterceptor(dio: dio),
    ]);
  }

  ///GET request using [Dio.get] method
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw NetworkExceptions.fromDioError(e);
    }
  }

  /// POST request using [Dio.post] method
  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await dio.post(path, data: data);
    } on DioException catch (e) {
      throw NetworkExceptions.fromDioError(e);
    }
  }

  /// PUT request using [Dio.put] method
  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await dio.put(path, data: data);
    } on DioException catch (e) {
      throw NetworkExceptions.fromDioError(e);
    }
  }

  ///DELETE request using [Dio.delete] method
  Future<Response> delete(String path, {dynamic data}) async {
    try {
      return await dio.delete(path, data: data);
    } on DioException catch (e) {
      throw NetworkExceptions.fromDioError(e);
    }
  }
}
