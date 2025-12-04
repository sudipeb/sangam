import 'package:dio/dio.dart';

/// A class to handle network exceptions based on Dio errors.
///
/// utilizes the [Exception] class to create custom exceptions for various network error scenarios.
class NetworkExceptions implements Exception {
  final String message;
  NetworkExceptions(this.message);
  @override
  String toString() => message;
  factory NetworkExceptions.fromDioError(dynamic error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkExceptions("Connection timeout with server");
      case DioExceptionType.sendTimeout:
        return NetworkExceptions("Send timeout with server");
      case DioExceptionType.receiveTimeout:
        return NetworkExceptions("Receive timeout with server");
      case DioExceptionType.badResponse:
        {
          switch (error.response?.statusCode) {
            case 400:
              return NetworkExceptions("Bad request");
            case 401:
              return NetworkExceptions("Unauthorized request");
            case 403:
              return NetworkExceptions("Forbidden");
            case 404:
              return NetworkExceptions("Not found");
            case 409:
              return NetworkExceptions("Email already registered. Please use a different email or login.");
            case 500:
              return NetworkExceptions("Internal server error");
            default:
              return NetworkExceptions(
                "Received invalid status code: ${error.response?.statusCode}",
              );
          }
        }
      case DioExceptionType.cancel:
        return NetworkExceptions("Request to server was cancelled");
      case DioExceptionType.unknown:
        return NetworkExceptions("Unexpected error occurred");
      default:
        return NetworkExceptions("Something went wrong");
    }
  }
}
