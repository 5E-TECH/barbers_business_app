import 'package:crown_cuts/core/constance/api_constance.dart';
import 'package:dio/dio.dart';


abstract class NetworkModule {

  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {"accept": "*/*",
          "Content-Type": "application/json"
        },
      ),
    );
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));
    return dio;
  }
}

class DioExceptions implements Exception {
  final String message;

  DioExceptions(this.message);

  static DioExceptions fromDioError(DioException error) {
    if (error.response?.data is Map<String, dynamic>) {
      final data = error.response!.data as Map<String, dynamic>;
      final serverMessage = data['message']?.toString();
      if (serverMessage != null && serverMessage.isNotEmpty) {
        return DioExceptions(serverMessage);
      }
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DioExceptions('Connection timeout. Please try again.');
      case DioExceptionType.sendTimeout:
        return DioExceptions('Request timeout. Please try again.');
      case DioExceptionType.receiveTimeout:
        return DioExceptions('Response timeout. Please try again.');
      case DioExceptionType.badResponse:
        return DioExceptions('Server error. Please try again.');
      case DioExceptionType.cancel:
        return DioExceptions('Request cancelled.');
      case DioExceptionType.connectionError:
        return DioExceptions('No internet connection.');
      case DioExceptionType.badCertificate:
        return DioExceptions('Bad certificate. Please try again.');
      case DioExceptionType.unknown:
        return DioExceptions('Unexpected error. Please try again.');
    }
  }

  @override
  String toString() => message;
}
