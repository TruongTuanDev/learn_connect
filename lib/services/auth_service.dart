import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:learn_connect/config/app_config.dart';
import 'package:learn_connect/data/models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_config.dart';

class AuthService {
  final Dio _dio;

  AuthService() : _dio = Dio(
    BaseOptions(

      // baseUrl: AppConfig.baseUrl.toString(),
      connectTimeout: const Duration(seconds: 10), // Thêm timeout
      receiveTimeout: const Duration(seconds: 10),

      baseUrl : AppConfig.baseUrl,
      // baseUrl: "http://127.0.0.1:8080",

    ),
  ) {
    // Thêm interceptor để log request/response
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint('Request: ${options.method} ${options.uri}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint('Response: ${response.statusCode} ${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        debugPrint('Error: ${e.message}');
        return handler.next(e);
      },
    ));
  }

  Future<Map<String, dynamic>> login(String user, String password) async {
    try {
      final response = await _dio.post(
        "/api/auth/signin",
        data: {
          'username': user,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        debugPrint('Login successful: ${response.data}');
        return {
          'success': true,
          'data': response.data,
          'accessToken': response.data['accessToken'],
          'userInfo': response.data['userInfo'],
          'matchedLanguagePartners': response.data['matchedLanguagePartners'],
          'addFriends': response.data['addFriends']
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? "Đăng nhập thất bại!"
        };
      }
    } on DioException catch (e) {
      debugPrint('Login error: ${e.toString()}');
      return {
        'success': false,
        'message': _handleDioError(e),
      };
    }
  }

  Future<String> signup(UserModel user) async {
    try {
      final response = await _dio.post(
        "/api/auth/signup",
        data: user.toJson(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        return response.data["id_user"]?.toString() ?? "Đăng ký thành công!";
      }
      return "Đăng ký thất bại: ${response.statusCode}";
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  String _handleDioError(DioException e) {
    if (e.response != null) {
      return e.response?.data['message']?.toString() ??
          "Lỗi server: ${e.response?.statusCode}";
    }
    return "Lỗi kết nối: ${e.message}";
  }

  // Thêm phương thức lưu token
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // Thêm phương thức đọc token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}