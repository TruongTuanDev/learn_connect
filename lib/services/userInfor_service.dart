import 'package:learn_connect/data/models/UserInfor.dart';
import 'package:dio/dio.dart';

import '../config/app_config.dart';

class UserInforService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
    ),
  );

  Future<String> updateInfor(UserInfo user) async {
    print("🔹 Bắt đầu gửi thông tin người dùng...");
    print("📩 Dữ liệu gửi đi: ${user.toJson()}");

    try {
      Response response = await _dio.post(
        "/api/auth/updateInfor",
        data: user.toJson(),
      );

      print("✅ Phản hồi từ server: ${response.data}");
      print("📡 HTTP Status: ${response.statusCode}");

      // Kiểm tra response có hợp lệ không
      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return response.data["message"]?.toString() ?? "Lưu thông tin thành công!";
      } else {
        return "❌ Lưu dữ liệu thất bại, mã lỗi: ${response.statusCode}";
      }
    } on DioException catch (e) {
      print("⚠️ Lỗi xảy ra: $e");

      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        return "❌ Lỗi: ${e.response!.data["message"]?.toString() ??
            "Không xác định"}";
      } else {
        return "❌ Lỗi kết nối. Vui lòng thử lại!";
      }
    }
  }
  Future<String> updatenewInfor(UserInfo user) async {
    print("🔹 Bắt đầu gửi thông tin người dùng...");
    print("📩 Dữ liệu gửi đi: ${user.toJson()}");

    try {
      Response response = await _dio.post(
        "/api/auth/updatenewInfor",
        data: user.toJson(),
      );

      print("✅ Phản hồi từ server: ${response.data}");
      print("📡 HTTP Status: ${response.statusCode}");

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return response.data["message"]?.toString() ?? "Cập nhật thông tin thành công!";
      } else {
        return "❌ Cập nhật dữ liệu thất bại, mã lỗi: ${response.statusCode}";
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