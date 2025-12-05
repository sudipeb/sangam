import 'package:dio/dio.dart';
import 'package:sangam/core/network/api_client.dart';

/// Thin wrapper around `ApiClient` providing a named service for REST calls.
/// Use this when you want a service-oriented DI registration similar to GraphQLService.
class RestApiService {
  static final RestApiService _instance = RestApiService._internal();
  final ApiClient _apiClient = ApiClient();

  RestApiService._internal();

  factory RestApiService() => _instance;

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _apiClient.get(path, queryParameters: queryParameters);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _apiClient.post(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _apiClient.put(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(String path, {dynamic data}) async {
    try {
      return await _apiClient.delete(path, data: data);
    } catch (e) {
      rethrow;
    }
  }
}
