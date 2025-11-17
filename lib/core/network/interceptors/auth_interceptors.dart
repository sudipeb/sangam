import 'package:dio/dio.dart';
import 'package:hive_ce/hive.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Example: Fetch token from Hive/SharedPreferences
    var box = await Hive.openBox('authBox');
    final token = box.get('token', defaultValue: '');
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}
