import 'package:dio/dio.dart';
import 'package:learn_connect/data/models/UserModel.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://127.0.0.1:8080",
    ),
  );
  Future<Map<String, dynamic>> login(String user, String password) async {
    try {
      Response response = await _dio.post(
        "/api/auth/signin",
        data: {
          'username': user,
          'password': password,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'data': response.data};
      } else {
        return {'success': false, 'message': response.data['message'] ?? "Đăng nhập thất bại!"};
      }
    } catch (e) {
      if (e is DioException) {
        return {'success': false, 'message': e.response?.data['message'] ?? "Lỗi kết nối đến server!"};
      } else {
        return {'success': false, 'message': "Có lỗi xảy ra!"};
      }
    }
  }
  Future<String> signup(UserModel user) async {
    print("🔹 Bắt đầu đăng ký...");
    print("📩 Dữ liệu gửi đi: ${user.toJson()}");

    try {
      Response response = await _dio.post(
        "/api/auth/signup",
        data: user.toJson(),
      );

      print("✅ Phản hồi từ server: ${response.data}");
      print("📡 HTTP Status: ${response.statusCode}");

      // Kiểm tra response có hợp lệ không
      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return response.data["message"]?.toString() ?? "Đăng ký thành công!";
      } else {
        return "❌ Đăng ký thất bại, mã lỗi: ${response.statusCode}";
      }
    } on DioException catch (e) {
      print("⚠️ Lỗi xảy ra: $e");

      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        return "❌ Lỗi: ${e.response!.data["message"]?.toString() ?? "Không xác định"}";
      } else {
        return "❌ Lỗi kết nối. Vui lòng thử lại!";
      }
    }
  }
}
