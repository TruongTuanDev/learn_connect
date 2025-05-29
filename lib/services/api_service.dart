import 'dart:convert';
import 'package:http/http.dart' as http;

import '../data/models/comment_model.dart';
import '../data/models/post.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8080/api'; // Thay bằng IP nếu chạy trên thiết bị thật

  static Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts: ${response.statusCode}');
    }
  }

  static Future<int> likePost(String postId, bool isLiked) async {
    final response = await http.post(
      Uri.parse('$baseUrl/like/$postId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'action': isLiked ? 'unlike' : 'like'}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['likeCount'];
    } else {
      throw Exception('Failed to update like: ${response.statusCode}');
    }
  }

  static Future<int> fetchLikeStatus(String postId) async {
    final response = await http.get(Uri.parse('$baseUrl/like/$postId'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['likeCount'];
    } else {
      throw Exception('Failed to fetch like status: ${response.statusCode}');
    }
  }

  static Future<List<CommentModel>> fetchComments(String postId) async {
    final response = await http.get(Uri.parse('$baseUrl/comment/$postId'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => CommentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load comments: ${response.statusCode}');
    }
  }

  static Future<CommentModel> addComment(String postId, String username, String content) async {
    final response = await http.post(
      Uri.parse('$baseUrl/comment/$postId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'content': content}),
    );
    if (response.statusCode == 201) {
      return CommentModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add comment: ${response.statusCode}');
    }
  }
}