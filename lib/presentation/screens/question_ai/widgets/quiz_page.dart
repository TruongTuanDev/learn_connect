import 'package:flutter/material.dart';
import '../models/quiz_question.dart';

class QuizPage extends StatelessWidget {
  final QuizQuestion question;
  final int index;
  final int totalQuestions;
  final bool quizCompleted;
  final Function(String?) onAnswerSelected;
  final VoidCallback onPreviousPressed;
  final VoidCallback onNextPressed;
  final bool isLastQuestion;

  const QuizPage({
    Key? key,
    required this.question,
    required this.index,
    required this.totalQuestions,
    required this.quizCompleted,
    required this.onAnswerSelected,
    required this.onPreviousPressed,
    required this.onNextPressed,
    required this.isLastQuestion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                color: Colors.white,
                shadowColor: Colors.blue.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.blue.shade200),
                            ),
                            child: Text(
                              'Question ${index + 1} of $totalQuestions',
                              style: TextStyle(
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (quizCompleted)
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    question.selectedAnswer ==
                                            question.correctAnswer
                                        ? Colors.green.shade50
                                        : Colors.red.shade50,
                              ),
                              child: Icon(
                                question.selectedAnswer ==
                                        question.correctAnswer
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color:
                                    question.selectedAnswer ==
                                            question.correctAnswer
                                        ? Colors.green
                                        : Colors.red,
                                size: 24,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        question.question,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ...question.options.asMap().entries.map((entry) {
                        final optionIndex = entry.key;
                        final option = entry.value;
                        final optionLetter = String.fromCharCode(
                          65 + optionIndex,
                        );

                        Color? tileColor;
                        Widget? trailing;

                        if (quizCompleted) {
                          bool isSelected =
                              optionLetter == question.selectedAnswer;
                          bool isCorrect =
                              optionLetter == question.correctAnswer;

                          if (isCorrect) {
                            tileColor = Colors.green[50];
                            trailing = const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            );
                          } else if (isSelected) {
                            tileColor = Colors.red[50];
                            trailing = const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            );
                          }
                        }

                        return RadioListTile<String>(
                          title: Text('$optionLetter. $option'),
                          value: optionLetter,
                          groupValue: question.selectedAnswer,
                          onChanged: quizCompleted ? null : onAnswerSelected,
                          activeColor:
                              quizCompleted
                                  ? (optionLetter == question.correctAnswer
                                      ? Colors.green
                                      : Colors.red)
                                  : Colors.blue,
                          tileColor: tileColor,
                          secondary: trailing,
                        );
                      }).toList(),
                      if (quizCompleted &&
                          question.selectedAnswer != question.correctAnswer)
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.amber[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.amber),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.lightbulb, color: Colors.amber),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'The correct answer is: ${question.correctAnswer}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber[900],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: index > 0 ? onPreviousPressed : null,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Previous'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black87,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: onNextPressed,
                  icon: Icon(
                    isLastQuestion ? Icons.check_circle : Icons.arrow_forward,
                  ),
                  label: Text(isLastQuestion ? 'Submit' : 'Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
