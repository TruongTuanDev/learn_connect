import 'package:learn_connect/data/models/UserInfor.dart';
import 'package:dio/dio.dart';

import '../config/app_config.dart';

class AddFriendService {
  final Dio _dio = Dio(
    BaseOptions(

      baseUrl: AppConfig.baseUrl,
    ),
  );


  Future<String> addFriend({
    required String idUser,
    required String idFriend,
    required String nameFriend,
    required String avatar,
  }) async {
    print("🔹 Bắt đầu gửi yêu cầu kết bạn...");
    final data = {
      "id_user": idUser,
      "id_friend": idFriend,
      "name_friend": nameFriend,
      "avatar": avatar,
    };
    print("📩 Dữ liệu gửi đi: $data");

    try {
      Response response = await _dio.post(
        "/api/friend/add",
        data: data,
      );

      print("✅ Phản hồi từ server: ${response.data}");
      print("📡 HTTP Status: ${response.statusCode}");

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return response.data["message"]?.toString() ?? "Đã gửi lời mời kết bạn!";
      } else {
        return "❌ Gửi lời mời thất bại, mã lỗi: ${response.statusCode}";
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
  Future<String> removeFriend({
    required String idUser,
    required String idFriend,
  }) async {
    print("🔹 Bắt đầu gửi yêu cầu hủy kết bạn...");
    final data = {
      "id_user": idUser,
      "id_friend": idFriend,
    };
    print("📤 Dữ liệu gửi đi: $data");

    try {
      Response response = await _dio.post(
        "/api/friend/remove",
        data: data,
      );

      print("✅ Phản hồi từ server: ${response.data}");
      print("📡 HTTP Status: ${response.statusCode}");

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return response.data["message"]?.toString() ?? "Đã hủy kết bạn thành công!";
      } else {
        return "❌ Hủy kết bạn thất bại, mã lỗi: ${response.statusCode}";
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