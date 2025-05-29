import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:learn_connect/config/app_config.dart';
import '../../../../services/flashcard_service.dart';
import '../models/flashcard_model.dart';
import '../services/gemini_service.dart';
import '../widgets/config_screen.dart';
import '../widgets/enhanced_card_side.dart';
import '../widgets/reaction_button.dart';

class FlashcardAIScreen extends StatefulWidget {
  final String? initialLanguage;
  final String? initialLevel;
  final String? initialTopic;

  const FlashcardAIScreen({
    Key? key,
    this.initialLanguage,
    this.initialLevel,
    this.initialTopic,
  }) : super(key: key);

  @override
  State<FlashcardAIScreen> createState() => _FlashcardAIScreenState();
}

class _FlashcardAIScreenState extends State<FlashcardAIScreen> {
  // Selected options
  late String selectedLanguage;
  late String selectedLevel;
  late String selectedTopic;

  // Flashcards list
  List<FlashcardModel> flashcards = [];

  // Page controller for flashcards
  final PageController _pageController = PageController();

  // Selected difficulty
  String selectedDifficulty = '';

  // Loading state
  bool isLoading = false;

  // Gemini service for generating flashcards
  final GeminiService _geminiService = GeminiService();

  @override
  void initState() {
    super.initState();
    selectedLanguage = widget.initialLanguage ?? 'English';
    selectedLevel = widget.initialLevel ?? 'Beginner';
    selectedTopic = widget.initialTopic ?? 'General';
  }

  // Generate flashcards using Gemini
  Future<void> generateFlashcards() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Call Gemini API to generate flashcards
      final prompt = """
      Generate 10 vocabulary flashcards for learning $selectedLanguage at $selectedLevel level about the topic '$selectedTopic'.
      Format each flashcard as follows:
      Word: [word]
      Pronunciation: [pronunciation]
      Definition: [definition]
      Example: [example sentence]
      
      Return only the formatted flashcards without any additional text.
      """;

      final response = await _geminiService.generateContent(prompt);
      print('📤 Nội dung sinh ra: ${response}');
      // Parse the response and create flashcard models
      final generatedFlashcards = parseFlashcardsFromResponse(response);

      final flashcardService = FlashcardService();
      await flashcardService.saveFlashcards(AppConfig.userId,response);

      setState(() {
        flashcards = generatedFlashcards;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to generate flashcards: ${e.toString()}'),
        ),
      );
    }
  }

  // Parse Gemini response to create flashcard models
  List<FlashcardModel> parseFlashcardsFromResponse(String response) {
    final List<FlashcardModel> parsedFlashcards = [];
    final List<String> cardTexts = response.split('\n\n');

    for (var cardText in cardTexts) {
      if (cardText.trim().isEmpty) continue;

      final lines = cardText.split('\n');
      String word = '', pronunciation = '', definition = '', example = '';

      for (var line in lines) {
        if (line.startsWith('Word:')) {
          word = line.replaceFirst('Word:', '').trim();
        } else if (line.startsWith('Pronunciation:')) {
          pronunciation = line.replaceFirst('Pronunciation:', '').trim();
        } else if (line.startsWith('Definition:')) {
          definition = line.replaceFirst('Definition:', '').trim();
        } else if (line.startsWith('Example:')) {
          example = line.replaceFirst('Example:', '').trim();
        }
      }

      if (word.isNotEmpty && definition.isNotEmpty) {
        parsedFlashcards.add(
          FlashcardModel(
            front: word,
            pronunciation: pronunciation,
            back: 'Definition: $definition\n\nExample: $example',
          ),
        );
      }
    }

    return parsedFlashcards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FF),
      appBar: AppBar(
        title: const Text('AI FLASHCARDS'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading:
            Navigator.canPop(context)
                ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                )
                : null,
        titleTextStyle: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          // Show configuration UI if no flashcards yet
          if (flashcards.isEmpty)
            Expanded(
              child: ConfigScreen(
                selectedLanguage: selectedLanguage,
                selectedTopic: selectedTopic,
                selectedLevel: selectedLevel,
                onLanguageChanged:
                    (val) => setState(() => selectedLanguage = val),
                onTopicChanged: (val) => setState(() => selectedTopic = val),
                onLevelChanged: (val) => setState(() => selectedLevel = val),
                onGenerateFlashcards: generateFlashcards,
                isLoading: isLoading,
              ),
            )
          else
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    '$selectedTopic - $selectedLevel'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: flashcards.length,
                      itemBuilder: (context, index) {
                        return buildEnhancedFlashcard(flashcards[index]);
                      },
                    ),
                  ),
                  // Difficulty rating buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ReactionButton(
                        icon: Icons.sentiment_satisfied,
                        label: 'Easy',
                        color: Colors.blue,
                        isSelected: selectedDifficulty == 'Easy',
                        onTap:
                            () => setState(() => selectedDifficulty = 'Easy'),
                      ),
                      ReactionButton(
                        icon: Icons.sentiment_neutral,
                        label: 'Medium',
                        color: Colors.orange,
                        isSelected: selectedDifficulty == 'Medium',
                        onTap:
                            () => setState(() => selectedDifficulty = 'Medium'),
                      ),
                      ReactionButton(
                        icon: Icons.sentiment_dissatisfied,
                        label: 'Hard',
                        color: Colors.red,
                        isSelected: selectedDifficulty == 'Hard',
                        onTap:
                            () => setState(() => selectedDifficulty = 'Hard'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Back to config button
                  TextButton(
                    onPressed: () {
                      setState(() {
                        flashcards = [];
                      });
                    },
                    child: Text(
                      'Create New Flashcards',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget buildEnhancedFlashcard(FlashcardModel flashcard) {
    return Center(
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        front: EnhancedCardSide(
          title: 'Word',
          content: flashcard.front,
          pronunciation: flashcard.pronunciation,
          isContentPrimary: true,
          textToSpeak: flashcard.front,
        ),
        back: EnhancedCardSide(
          title: 'Definition',
          content: flashcard.back,
          isContentPrimary: false,
          textToSpeak: flashcard.back,
        ),
      ),
    );
  }
}
