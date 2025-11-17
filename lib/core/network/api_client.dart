import 'package:dio/dio.dart';
import 'package:sangam/core/constants/api_constants.dart';
import 'package:sangam/core/network/network_exceptions.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late final Dio dio;
  factory ApiClient() => _instance;
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
    dio.interceptors.addAll([]);
  }

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

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await dio.get(path, data: data);
    } on DioException catch (e) {
      throw NetworkExceptions.fromDioError(e);
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await dio.put(path, data: data);
    } on DioException catch (e) {
      throw NetworkExceptions.fromDioError(e);
    }
  }

  Future<Response> delete(String path, {dynamic data}) async {
    try {
      return await dio.delete(path, data: data);
    } on DioException catch (e) {
      throw NetworkExceptions.fromDioError(e);
    }
  }
}
