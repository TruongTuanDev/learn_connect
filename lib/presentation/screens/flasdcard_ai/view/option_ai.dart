import 'package:flutter/material.dart';
import 'package:learn_connect/presentation/screens/flasdcard_ai/view/flashcard_screen.dart';
import 'package:learn_connect/presentation/screens/flasdcard_ai/widgets/config_screen.dart';
import 'package:learn_connect/routes/routes.dart';
import '../models/flashcard_model.dart';
import '../services/gemini_service.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  String selectedLanguage = 'English';
  String selectedTopic = 'Vocabulary';
  String selectedLevel = 'Easy';
  bool isLoading = false;
  bool showConfigScreen = true;

  final List<String> languages = [
    'Korean', 'English', 'Vietnamese', 'French', 'Spanish', 'Japanese',
  ];

  final List<String> topics = [
    'Vocabulary', 'Grammar', 'Conversation', 'Business English', 'Academic English',
  ];

  final List<String> levels = ['Easy', 'Medium', 'Hard', 'Expert'];

  void _startQuiz() async {
    final geminiService = GeminiService();

    try {
      // Gọi API để lấy danh sách flashcards
      final flashcards = await geminiService.generateFlashcards(
        language: selectedLanguage,
        topic: selectedTopic,
        difficulty: selectedLevel,
      );

      // Chuyển sang màn hình TestAiScreen và truyền dữ liệu flashcards
      if (flashcards.isNotEmpty) {
        Navigator.pushNamed(
          context,
          AppRoutes.flascard_ai, // hoặc dùng MaterialPageRoute
          arguments: {
            'flashcard': flashcards[0],
            'items': flashcards,
          },
        );
      }
    } catch (e) {
      print('Error fetching flashcards: $e');
      // Hiển thị thông báo lỗi nếu API call thất bại
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error: ${e.toString()}')),
      );
    }
  }
  Widget _buildConfigScreen() {
    return ConfigScreen(
      selectedLanguage: selectedLanguage,
      selectedTopic: selectedTopic,
      selectedLevel: selectedLevel,
      languages: languages,
      topics: topics,
      levels: levels,
      onLanguageChanged: (val) => setState(() => selectedLanguage = val),
      onTopicChanged: (val) => setState(() => selectedTopic = val),
      onLevelChanged: (val) => setState(() => selectedLevel = val),
      onStartQuiz: _startQuiz,
      isLoading: isLoading,
    );
  }
  void goToConfigScreen() {
    setState(() {
      showConfigScreen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    _buildConfigScreen();
    throw UnimplementedError();
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Select Quiz Parameters'),
  //       leading: Navigator.canPop(context)
  //           ? IconButton(
  //         icon: const Icon(Icons.arrow_back),
  //         onPressed: () => Navigator.of(context).pop(),
  //       )
  //           : null,
  //       flexibleSpace: Container(
  //         decoration: BoxDecoration(
  //           gradient: LinearGradient(
  //             colors: [Colors.blue.shade800, Colors.blue.shade500],
  //             begin: Alignment.topLeft,
  //             end: Alignment.bottomRight,
  //           ),
  //         ),
  //       ),
  //       elevation: 0,
  //       foregroundColor: Colors.white,
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         children: [
  //           // Dropdown cho ngôn ngữ
  //           DropdownButton<String>(
  //             value: selectedLanguage,
  //             onChanged: (value) {
  //               setState(() {
  //                 selectedLanguage = value!;
  //               });
  //             },
  //             items: languages
  //                 .map<DropdownMenuItem<String>>(
  //                   (String value) => DropdownMenuItem<String>(
  //                 value: value,
  //                 child: Text(value),
  //               ),
  //             )
  //                 .toList(),
  //           ),
  //           const SizedBox(height: 16),
  //
  //           // Dropdown cho chủ đề
  //           DropdownButton<String>(
  //             value: selectedTopic,
  //             onChanged: (value) {
  //               setState(() {
  //                 selectedTopic = value!;
  //               });
  //             },
  //             items: topics
  //                 .map<DropdownMenuItem<String>>(
  //                   (String value) => DropdownMenuItem<String>(
  //                 value: value,
  //                 child: Text(value),
  //               ),
  //             )
  //                 .toList(),
  //           ),
  //           const SizedBox(height: 16),
  //
  //           // Dropdown cho độ khó
  //           DropdownButton<String>(
  //             value: selectedLevel,
  //             onChanged: (value) {
  //               setState(() {
  //                 selectedLevel = value!;
  //               });
  //             },
  //             items: levels
  //                 .map<DropdownMenuItem<String>>(
  //                   (String value) => DropdownMenuItem<String>(
  //                 value: value,
  //                 child: Text(value),
  //               ),
  //             )
  //                 .toList(),
  //           ),
  //           const SizedBox(height: 32),
  //
  //           // Nút bắt đầu quiz
  //           ElevatedButton(
  //             onPressed: _startQuiz,
  //             child: const Text('Start'),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
