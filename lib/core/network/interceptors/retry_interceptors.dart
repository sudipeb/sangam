import 'package:dio/dio.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final Dio dio;
  final int retires;
  final Duration retryDelays;
  RetryOnConnectionChangeInterceptor({
    required this.dio,
    this.retires = 3,
    this.retryDelays = const Duration(seconds: 3),
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    int retryCount = 0;
    while (retryCount < retires && _shouldRetry(err)) {
      retryCount++;
      await Future.delayed(retryDelays);
      try {
        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        err = e as DioException;
      }
    }
    return super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.receiveTimeout;
  }
}
