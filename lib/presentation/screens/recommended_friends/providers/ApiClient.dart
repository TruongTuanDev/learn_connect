import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  final Dio _dio;
  final String baseUrl;

  ApiClient({required this.baseUrl})
      : _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  )) {
    // Thêm interceptor nếu cần
    _dio.interceptors.add(LogInterceptor(
      request: true,
      responseBody: true,
      error: true,
    ));
  }

  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {

    }
  }

  dynamic _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:

      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response!);
      case DioExceptionType.cancel:

      case DioExceptionType.unknown:

      default:

    }
  }

  dynamic _handleBadResponse(Response response) {
    switch (response.statusCode) {
      case 400:
      case 401:
      case 403:
      case 404:
      case 500:
      default:
    }
  }
}

// Giữ nguyên các exception class như cũ