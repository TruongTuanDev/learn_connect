import 'package:dio/dio.dart';
import 'package:learn_connect/data/models/UserModel.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://localhost:8080/api",
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  );

  Future<String> signup(UserModel user) async {
    print("ok vào nha");
    print("User JSON: ${user.toJson()}");  // Kiểm tra dữ liệu người dùng gửi đi

    try {
      Response response = await _dio.post(
        "/auth/signup",
        data: user.toJson(),
      );

      // In ra toàn bộ phản hồi từ server
      print("Response: ${response.data}");

      // Kiểm tra mã trạng thái HTTP
      print("HTTP Status: ${response.statusCode}");

      // Nếu thành công, trả về thông báo từ server
      if (response.statusCode == 200) {
        return response.data["message"];
      } else {
        return "Signup failed with status code: ${response.statusCode}";
      }

    } on DioException catch (e) {
      // Kiểm tra lỗi nếu có
      if (e.response != null) {
        print("Error response: ${e.response!.data}");
        return "Error: ${e.response!.data["message"]}";
      } else {
        print("Request error: ${e.message}");
        return "Signup failed. Please try again.";
      }
    }
  }
}
