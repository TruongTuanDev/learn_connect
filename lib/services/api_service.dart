import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learn_connect/data/models/post.dart';

class ApiService {
  static const String _baseUrl = 'http://127.0.0.1:8080';
  // Nếu chạy trên thiết bị thật thì đổi thành: http://192.168.x.x:8080

  // 📌 Fetch Post (mẫu ban đầu)
  static Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('$_baseUrl/posts'));
    if (response.statusCode == 200) {
      final List jsonList = json.decode(response.body);
      return jsonList.map((e) => Post.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

}
