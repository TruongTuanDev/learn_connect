import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'widgets/enhanced_card_side.dart';
import 'model/flashcard_model.dart';
import 'service/gemini_service.dart';

void main() {
  runApp(
    const MaterialApp(
      home: TopicGridScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class TopicGridScreen extends StatefulWidget {
  const TopicGridScreen({Key? key}) : super(key: key);

  @override
  State<TopicGridScreen> createState() => _TopicGridScreenState();
}

class _TopicGridScreenState extends State<TopicGridScreen> {
  final List<Map<String, String>> topics = const [
    {'title': 'Comunication', 'image': 'assets/images/comunication.png'},
    {'title': 'Hobbies', 'image': 'assets/images/Hobbies.png'},
    {'title': 'Music', 'image': 'assets/images/music.png'},
    {'title': 'Work', 'image': 'assets/images/work.png'},
    {'title': 'Food', 'image': 'assets/images/food.png'},
    {'title': 'Beauty', 'image': 'assets/images/Beauty.png'},
    {'title': 'Cooking', 'image': 'assets/images/Cooking.png'},
    {'title': 'Shopping', 'image': 'assets/images/Shopping.png'},
    {'title': 'Books', 'image': 'assets/images/Books.png'},
    {'title': 'Sport', 'image': 'assets/images/Sport.png'},
  ];

  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  List<Map<String, String>> get filteredTopics {
    if (_searchText.isEmpty) return topics;
    return topics
        .where(
          (topic) =>
              topic['title']!.toLowerCase().contains(_searchText.toLowerCase()),
        )
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar with back button and search box
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: Container(
                width: double.infinity, // chiếm toàn bộ chiều ngang
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.12),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 0,
                ), // không margin ngang
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 20,
                ), // padding trong cho đẹp
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, size: 30),
                      onPressed: () {
                        Navigator.of(context).maybePop();
                      },
                    ),
                    Expanded(
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                onChanged: (value) {
                                  setState(() {
                                    _searchText = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Search',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 26,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(24),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                  childAspectRatio: 1,
                ),
                itemCount: filteredTopics.length,
                itemBuilder: (context, index) {
                  final topic = filteredTopics[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => FlashcardAIScreen(
                                initialLanguage: 'English',
                                initialLevel: 'Intermediate',
                                initialTopic: topic['title']!,
                              ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          // Bóng xiên chỉ ở cạnh phải và dưới
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.18),
                            spreadRadius: 0,
                            blurRadius: 18,
                            offset: const Offset(10, 10), // bóng xiên phải-dưới
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 7,
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Image.asset(
                                topic['image']!,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Flexible(
                            flex: 2,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                topic['title']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Flashcard AI Screen
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
  late String selectedLanguage;
  late String selectedLevel;
  late String selectedTopic;

  List<FlashcardModel> flashcards = [];
  final PageController _pageController = PageController();
  String selectedDifficulty = '';
  bool isLoading = false;
  final GeminiService _geminiService = GeminiService();

  @override
  void initState() {
    super.initState();
    selectedLanguage = 'English';
    selectedLevel = 'Intermediate';
    selectedTopic = widget.initialTopic ?? 'General';
    generateFlashcards();
  }

  Future<void> generateFlashcards() async {
    setState(() {
      isLoading = true;
    });

    try {
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

      final generatedFlashcards = parseFlashcardsFromResponse(response);

      setState(() {
        flashcards = generatedFlashcards;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to generate flashcards: ${e.toString()}'),
        ),
      );
    }
  }

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
        title: const Text('FLASHCARDS'),
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
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : flashcards.isEmpty
              ? Center(
                child: Text(
                  'No flashcards generated.',
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
              )
              : Column(
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

                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        flashcards = [];
                        generateFlashcards();
                      });
                    },
                    child: Text(
                      'New Flashcards',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
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
