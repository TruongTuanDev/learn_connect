import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../flasdcard_ai/widgets/config_screen.dart';
import 'gemini_service.dart';

// Thêm hàm main và widget app

class PronunciationPracticeAIApp extends StatelessWidget {
  const PronunciationPracticeAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Luyện tập phát âm',
      home: PronunciationPracticeAIScreen(),
    );
  }
}

class PronunciationPracticeAIScreen extends StatefulWidget {
  const PronunciationPracticeAIScreen({Key? key}) : super(key: key);

  @override
  State<PronunciationPracticeAIScreen> createState() =>
      _PronunciationPracticeAIScreenState();
}

class _PronunciationPracticeAIScreenState
    extends State<PronunciationPracticeAIScreen> {
  String selectedLanguage = 'English';
  String selectedLevel = 'Beginner';
  String selectedTopic = 'General';

  final GeminiService _geminiService = GeminiService();
  bool isLoading = false;
  List<String> words = [];
  int currentIndex = 0;

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _recognizedText = '';
  String _result = '';
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  Future<void> generateWords() async {
    setState(() {
      isLoading = true;
      words = [];
      currentIndex = 0;
      _recognizedText = '';
      _result = '';
    });

    final prompt = """
Generate 10 vocabulary words for learning $selectedLanguage at $selectedLevel level about the topic '$selectedTopic'.
Format: [word]
Return only the list of words, one per line, no extra text.
""";
    try {
      final response = await _geminiService.generateContent(prompt);
      final generatedWords =
          response
              .split('\n')
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList();
      setState(() {
        words = generatedWords;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to generate words: $e')));
    }
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) {
            setState(() {
              _recognizedText = val.recognizedWords;
              _result =
                  _comparePronunciation(_recognizedText, words[currentIndex])
                      ? "Đúng!"
                      : "Sai, hãy thử lại!";
            });
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  bool _comparePronunciation(String user, String target) {
    return user.trim().toLowerCase() == target.trim().toLowerCase();
  }

  void _speak() async {
    if (words.isNotEmpty) {
      await _flutterTts.speak(words[currentIndex]);
    }
  }

  void _nextWord() {
    if (currentIndex < words.length - 1) {
      setState(() {
        currentIndex++;
        _recognizedText = '';
        _result = '';
      });
    }
  }

  void _prevWord() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        _recognizedText = '';
        _result = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue.shade800),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Luyện tập phát âm',
          style: TextStyle(
            color: Colors.blue.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.blue.shade800),
      ),
      backgroundColor: Colors.white, // Nền trắng cho toàn bộ trang
      body:
          words.isEmpty
              ? ConfigScreen(
                selectedLanguage: selectedLanguage,
                selectedTopic: selectedTopic,
                selectedLevel: selectedLevel,
                onLanguageChanged:
                    (val) => setState(() => selectedLanguage = val),
                onTopicChanged: (val) => setState(() => selectedTopic = val),
                onLevelChanged: (val) => setState(() => selectedLevel = val),
                onGenerateFlashcards: generateWords,
                isLoading: isLoading,
              )
              : Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Từ vựng (${currentIndex + 1}/${words.length}):',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      words[currentIndex],
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _speak,
                      icon: const Icon(Icons.volume_up),
                      label: const Text('Nghe phát âm'),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: _listen,
                      icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                      label: Text(_isListening ? 'Đang nghe...' : 'Phát âm'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isListening ? Colors.red : null,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Bạn vừa nói: $_recognizedText',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _result,
                      style: TextStyle(
                        fontSize: 22,
                        color: _result == "Đúng!" ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: _prevWord,
                          child: const Text('Trước'),
                        ),
                        ElevatedButton(
                          onPressed: _nextWord,
                          child: const Text('Tiếp'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          words = [];
                          currentIndex = 0;
                          _recognizedText = '';
                          _result = '';
                        });
                      },
                      child: const Text('Tạo bộ từ mới'),
                    ),
                  ],
                ),
              ),
    );
  }
}
