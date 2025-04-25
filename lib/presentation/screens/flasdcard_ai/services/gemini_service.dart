import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/flashcard_model.dart';

class GeminiService {
  final String apiKey = 'AIzaSyDIvnfYDW-rmfIIgrTlg82p0jmhFC8Rcwc';
  final String apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

  Future<List<FlashCardItem>> generateFlashcards({
    required String language,
    required String topic,
    required String difficulty,
  }) async {
    final prompt = '''
Create a list of 10 detailed $language flashcards about "$topic" with $difficulty difficulty.
Each flashcard should include these fields:
- "word": The main word or phrase
- "type": Part of speech (noun, verb, adjective, etc.)
- "phonetic": Pronunciation in IPA format
- "definition": A brief $language definition
- "example_en": An example sentence in $language
- "example_vi": A Vietnamese translation of the example sentence
- "audioUrl": A URL pointing to a sample pronunciation audio (can be a placeholder)
Format the response as a JSON array:
[
  {
    "word": "example",
    "type": "noun",
    "phonetic": "/ɪɡˈzæmpəl/",
    "definition": "A thing characteristic of its kind",
    "example_en": "This is an example sentence.",
    "example_vi": "Đây là một câu ví dụ.",
    "audioUrl": "https://example.com/audio.mp3"
  },
  ...
]
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

      final jsonPattern = RegExp(r'\[\s*\{.*?\}\s*\]', dotAll: true);
      final match = jsonPattern.firstMatch(textResponse);

      if (match != null) {
        final jsonStr = match.group(0);
        final List<dynamic> flashcardJson = jsonDecode(jsonStr!);


        return flashcardJson.map((item) {
          return FlashCardItem(
            word: item['word'] ?? '',
            type: item['type'] ?? '',
            phonetic: item['phonetic'] ?? '',
            definition: item['definition'] ?? '',
            example_en: item['example_en'] ?? '',
            example_vi: item['example_vi'] ?? '',
            audioUrl: item['audioUrl'] ?? '',
          );
        }).toList();
      } else {
        throw Exception('❌ Không thể phân tích dữ liệu flashcard từ phản hồi.');
      }
    } else {
      throw Exception('❌ Lỗi khi gọi API Gemini: ${response.statusCode}');
    }
  }
}
