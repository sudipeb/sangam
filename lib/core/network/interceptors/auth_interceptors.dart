import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  // Lazy singleton for secure storage
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AuthInterceptor({required this.dio});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final token = await _storage.read(key: 'accesstoken');
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      print('Error reading token: $e');
    }

    handler.next(options); // continue
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final refreshToken = await _storage.read(key: 'refreshtoken');
        if (refreshToken != null && refreshToken.isNotEmpty) {
          final response = await dio.post(
            '/auth/refresh',
            data: {'refreshToken': refreshToken},
          );

          final newAccessToken = response.data['accesstoken'];
          final newRefreshToken = response.data['refreshToken'];

          await _storage.write(key: 'accesstoken', value: newAccessToken);
          await _storage.write(key: 'refreshtoken', value: newRefreshToken);

          // Retry original request
          final opts = err.requestOptions;
          opts.headers['Authorization'] = 'Bearer $newAccessToken';
          final cloneReq = await dio.request(
            opts.path,
            options: Options(method: opts.method, headers: opts.headers),
            data: opts.data,
            queryParameters: opts.queryParameters,
          );
          return handler.resolve(cloneReq);
        }
      } catch (e) {
        print('Refresh token failed: $e');
        await _storage.deleteAll(); // clear tokens on failure
        return handler.reject(err);
      }
    }

    handler.next(err); // continue
  }
}
