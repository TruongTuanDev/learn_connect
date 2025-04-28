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
Word: Innovation
Pronunciation: /ˌɪnəˈveɪʃən/
Definition: A new idea, method, or device; the introduction of something new
Example: The company's latest innovation has revolutionized the industry.

Word: Sustainable
Pronunciation: /səˈsteɪnəbl/
Definition: Able to be maintained at a certain rate or level; conserving resources
Example: They developed a sustainable business model that minimizes environmental impact.

Word: Algorithm
Pronunciation: /ˈælɡəˌrɪðəm/
Definition: A process or set of rules to be followed in calculations or problem-solving operations
Example: The search engine uses a complex algorithm to rank web pages.
      """;
    }
  }
}
