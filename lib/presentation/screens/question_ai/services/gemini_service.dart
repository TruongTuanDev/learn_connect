import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../config/app_config.dart';
import '../../../../services/flashcard_service.dart';
import '../models/quiz_question.dart';

class GeminiService {
  final String apiKey = 'AIzaSyDIvnfYDW-rmfIIgrTlg82p0jmhFC8Rcwc';
  final String apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

  Future<List<QuizQuestion>> generateQuiz({
    required String language,
    required String topic,
    required String difficulty,
  }) async {
    final flashcardService = FlashcardService();
    String words =  await flashcardService.fetchWords(AppConfig.userId);
    print("Từ mày muốn in "+ words);
    final prompt = '''
Create a multiple-choice quiz about $words .
Generate 5 questions, each with 4 answer options (A, B, C, D).
Format the response as a JSON array with the following structure for each question:
{
  "question": "The question text",
  "options": ["Option A", "Option B", "Option C", "Option D"],
  "correctAnswer": "The correct option (A, B, C, or D)"
}
''';

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
      final textResponse = data['candidates'][0]['content']['parts'][0]['text'];

      final jsonPattern = RegExp(r'\[\s*\{.*\}\s*\]', dotAll: true);
      final match = jsonPattern.firstMatch(textResponse);

      if (match != null) {
        final jsonStr = match.group(0);
        final List<dynamic> questionsJson = jsonDecode(jsonStr!);
        return questionsJson.map((q) => QuizQuestion.fromJson(q)).toList();
      } else {
        throw Exception('Could not parse quiz data from response');
      }
    } else {
      throw Exception('Failed to load quiz: ${response.statusCode}');
    }
  }
}
