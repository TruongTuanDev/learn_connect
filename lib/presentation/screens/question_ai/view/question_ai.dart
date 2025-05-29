import 'package:flutter/material.dart';
import '../models/quiz_question.dart';
import '../services/gemini_service.dart';
import '../widgets/config_screen.dart';
import '../widgets/quiz_page.dart';
import '../widgets/results_page.dart';

class TestAiScreen extends StatefulWidget {
  const TestAiScreen({Key? key}) : super(key: key);

  @override
  _TestAiScreenState createState() => _TestAiScreenState();
}

class _TestAiScreenState extends State<TestAiScreen> {
  String selectedLanguage = 'English';
  String selectedTopic = 'Vocabulary';
  String selectedLevel = 'Easy';
  bool isLoading = false;
  List<QuizQuestion> quizQuestions = [];
  bool quizCompleted = false;
  int score = 0;
  int currentQuestionIndex = 0;
  bool showConfigScreen = true;
  final PageController _pageController = PageController();

  final List<String> languages = [
    'Korean',
    'English',
    'Vietnamese',
    'French',
    'Spanish',
    'Japanese',
  ];

  final List<String> topics = [
    'Vocabulary',
    'Grammar',
    'Conversation',
    'Business English',
    'Academic English',
  ];

  final List<String> levels = ['Easy', 'Medium', 'Hard', 'Expert'];

  final GeminiService _geminiService = GeminiService();

  Future<void> fetchQuizFromGemini() async {
    setState(() {
      isLoading = true;
      quizQuestions = [];
      quizCompleted = false;
      showConfigScreen = false;
      currentQuestionIndex = 0;
    });

    try {
      final questions = await _geminiService.generateQuiz(
        language: selectedLanguage,
        topic: selectedTopic,
        difficulty: selectedLevel,
      );

      setState(() {
        quizQuestions = questions;
        isLoading = false;
        if (_pageController.hasClients) {
          _pageController.jumpToPage(0);
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        showConfigScreen = true;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  void checkAnswers() {
    int totalCorrect = 0;
    for (var question in quizQuestions) {
      if (question.selectedAnswer == question.correctAnswer) {
        totalCorrect++;
      }
    }

    setState(() {
      score = totalCorrect;
      quizCompleted = true;
      _pageController.animateToPage(
        quizQuestions.length,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void resetQuiz() {
    setState(() {
      quizCompleted = false;
      for (var question in quizQuestions) {
        question.selectedAnswer = null;
      }
      currentQuestionIndex = 0;
      _pageController.jumpToPage(0);
    });
  }

  void goToConfigScreen() {
    setState(() {
      showConfigScreen = true;
      quizQuestions = [];
      quizCompleted = false;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Học ngoại ngữ'),
        leading:
            Navigator.canPop(context)
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                )
                : null,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade800, Colors.blue.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: showConfigScreen ? _buildConfigScreen() : _buildQuizScreen(),
      ),
    );
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
      onStartQuiz: fetchQuizFromGemini,
      isLoading: isLoading,
    );
  }

  Widget _buildQuizScreen() {
    if (isLoading && quizQuestions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                color: Colors.blue.shade700,
                strokeWidth: 4,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Tạo câu hỏi trắc nghiệm của bạn...',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Đợi một lúc',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
            ),
          ],
        ),
      );
    }

    return PageView.builder(
      controller: _pageController,
      itemCount: quizQuestions.length + 1,
      onPageChanged: (index) {
        setState(() {
          currentQuestionIndex = index;
        });
      },
      itemBuilder: (context, index) {
        if (index == quizQuestions.length) {
          return ResultsPage(
            score: score,
            totalQuestions: quizQuestions.length,
            onResetQuiz: resetQuiz,
            onNewQuiz: goToConfigScreen,
            onReviewQuestions: () {
              _pageController.animateToPage(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          );
        }

        return QuizPage(
          question: quizQuestions[index],
          index: index,
          totalQuestions: quizQuestions.length,
          quizCompleted: quizCompleted,
          onAnswerSelected: (value) {
            setState(() {
              quizQuestions[index].selectedAnswer = value;
            });
          },
          onPreviousPressed: () {
            _pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          onNextPressed: () {
            if (index == quizQuestions.length - 1) {
              bool allAnswered = quizQuestions.every(
                (q) => q.selectedAnswer != null,
              );
              if (allAnswered) {
                checkAnswers();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Vui lòng trả lời tất cả các câu hỏi trước khi gửi',
                    ),
                  ),
                );
              }
            } else {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
          isLastQuestion: index == quizQuestions.length - 1,
        );
      },
    );
  }
}

void main() {
  runApp(const TestAiApp());
}

class TestAiApp extends StatelessWidget {
  const TestAiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Bài kiểm tra',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue.shade700,
          secondary: Colors.blue.shade500,
          surface: Colors.white,
          background: Colors.blue.shade50,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.blue.shade50,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue.shade600,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const TestAiScreen(),
    );
  }
}
