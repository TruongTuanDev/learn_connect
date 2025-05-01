import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  final String apiKey = 'AIzaSyDIvnfYDW-rmfIIgrTlg82p0jmhFC8Rcwc';
  final String apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

  Future<String> generateContent(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt},
              ],
            },
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['candidates'][0]['content']['parts'][0]['text'];
      } else {
        throw Exception('Failed to generate content: ${response.statusCode}');
      }
    } catch (e) {
      // If API fails, return dummy data for testing
      await Future.delayed(const Duration(seconds: 2));
      return """
apple
banana
orange
grape
watermelon
pineapple
strawberry
peach
lemon
cherry
      """;
    }
  }
}
