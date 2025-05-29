import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';

class FlashcardService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl, // Thay đổi nếu chạy trên thiết bị thật hoặc emulator
    ),
  );

  Future<Map<String, dynamic>> getTopics() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('access_token');

      if (token == null || token.isEmpty) {
        return {
          'success': false,
          'message': "Token bị thiếu. Vui lòng đăng nhập lại.",
        };
      } else {
        print("✅ Có token, tiến hành gọi API...");
      }

      Response response = await _dio.get(
        "/api/flashcard/topics",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            // Nếu backend cần token:
            // 'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        print("📥 Dữ liệu nhận được từ API: $data");

        if (data is List) {
          // Mỗi phần tử là 1 object: { id: ..., enabled: ..., status: ..., title: ..., description: ..., language: ..., created_at: ..., updated_at: ... }
          List<Map<String, dynamic>> topics = data
              .map((item) => {
            'id': item['id'],
            'enabled': item['enabled'],
            'status': item['status'],
            'title': item['title'],
            'description': item['description'],
            'language': item['language'],
            'created_at': item['created_at'],
            'updated_at': item['updated_at'],
          })
              .toList();

          return {
            'success': true,
            'data': topics,
          };
        } else {
          return {
            'success': false,
            'message': "Dữ liệu không đúng định dạng mong đợi (List).",
          };
        }
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? "Lỗi từ server.",
        };
      }
    } catch (e) {
      if (e is DioException) {
        return {
          'success': false,
          'message': e.response?.data['message'] ??
              "Không thể kết nối đến server.",
        };
      } else {
        return {
          'success': false,
          'message': "Lỗi không xác định: ${e.toString()}",
        };
      }
    }
  }
  Future<Map<String, dynamic>> getItemsByTopicId(String topicId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('access_token');

      if (token == null || token.isEmpty) {
        return {
          'success': false,
          'message': "Token bị thiếu. Vui lòng đăng nhập lại.",
        };
      } else {
        print("✅ Có token, gọi API lấy danh sách item theo topic...");
      }

      Response response = await _dio.get(
        "/api/flashcard/topics/$topicId/items",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            // 'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        print("📥 Dữ liệu item nhận được từ API: $data");

        if (data is List) {
          // ⚠️ Cập nhật cho khớp với FlashCardItem
          List<Map<String, dynamic>> items = data.map((item) => {
            'id': item['id'],
            'word': item['word'],
            'type': item['type'],
            'phonetic': item['phonetic'],
            'definition': item['definition'],
            'example_en': item['example_en'],
            'example_vi': item['example_vi'],
            'audioUrl': item['audioUrl'],
          }).toList();

          return {
            'success': true,
            'data': items,
          };
        } else {
          return {
            'success': false,
            'message': "Dữ liệu không đúng định dạng mong đợi (List).",
          };
        }
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? "Lỗi từ server.",
        };
      }
    } catch (e) {
      if (e is DioException) {
        return {
          'success': false,
          'message': e.response?.data['message'] ?? "Không thể kết nối đến server.",
        };
      } else {
        return {
          'success': false,
          'message': "Lỗi không xác định: ${e.toString()}",
        };
      }
    }
  }

}
