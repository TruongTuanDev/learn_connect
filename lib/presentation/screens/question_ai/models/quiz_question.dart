import 'package:flutter/foundation.dart';

class QuizQuestion {
  final String question;
  final List<String> options;
  final String correctAnswer;
  String? selectedAnswer;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.selectedAnswer,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      question: json['question'],
      options: List<String>.from(json['options']),
      correctAnswer: json['correctAnswer'],
    );
  }
}
