import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeminiService {

  Future<String> sendMessage(String prompt) async {
    final String apiKey = 'AIzaSyDIvnfYDW-rmfIIgrTlg82p0jmhFC8Rcwc';
    final dio = Dio();

    final response = await dio.post(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-lite:generateContent?key=$apiKey',
      options: Options(headers: {'Content-Type': 'application/json'}),
      data: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": prompt}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      return response.data['candidates'][0]['content']['parts'][0]['text'] ?? "No response";
    } else {
      throw Exception('Failed to get response: ${response.statusCode}');
    }
  }
}

