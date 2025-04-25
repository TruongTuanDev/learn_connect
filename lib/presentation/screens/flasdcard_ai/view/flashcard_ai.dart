import 'package:flutter/material.dart';
import 'flashcard_ai_screen.dart';

// Export main screen for easy importing elsewhere
export 'flashcard_ai_screen.dart';

// Main entry point when running standalone
void main() {
  runApp(const FlashcardAIApp());
}

// App wrapper for standalone running
class FlashcardAIApp extends StatelessWidget {
  const FlashcardAIApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Vocabulary Flashcards',
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
      home: const FlashcardAIScreen(),
    );
  }
}
