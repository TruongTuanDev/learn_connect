import 'package:flutter/material.dart';
import '../../search_flash_card/model/search_flash_card_model.dart';
import '../models/flashcard_model.dart';
import '../widgets/flashcard_widget.dart';
import 'package:learn_connect/services/flashcard_service.dart';

class FlashcardScreen extends StatefulWidget {

  @override
  _FlashcardScreenState createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {

  late FlashCard flashcard;
  List<FlashCardItem> flashcards = [];
  bool isLoading = true;
  bool isInitialized = false;
  final PageController _pageController = PageController();
  String selectedDifficulty = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Chỉ chạy 1 lần
    if (!isInitialized) {
      final args = ModalRoute.of(context)?.settings.arguments;
      print(args);
      if (args != null && args is FlashCard) {
        flashcard = args;
        loadFlashcards();
        isInitialized = true;
      } else {
        print('⚠️ Không nhận được dữ liệu FlashCard từ trang trước!');
      }
    }
  }

  Future<void> loadFlashcards() async {
    try {
      final flashcardService = FlashcardService();
      final result = await flashcardService.getItemsByTopicId(flashcard.id);

      if (result['success'] == true) {
        final List<dynamic> jsonList = result['data'];
        setState(() {
          flashcards = jsonList
              .map((item) => FlashCardItem.fromJson(item as Map<String, dynamic>))
              .toList();
          isLoading = false;
        });
      } else {
        throw Exception(result['message'] ?? '❌ Không thể tải dữ liệu');
      }
    } catch (e) {
      print('🛑 Lỗi khi load flashcards: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F9FF),
      appBar: AppBar(
        title: Text('FLASHCARDS'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        titleTextStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          SizedBox(height: 20),
          Text(
            flashcard.title.toUpperCase(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: flashcards.length,
              itemBuilder: (context, index) {
                return FlashcardWidget(flashcard: flashcards[index]);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ReactionButton(
                icon: Icons.sentiment_satisfied,
                label: 'Dễ',
                color: Colors.blue,
                isSelected: selectedDifficulty == 'Dễ',
                onTap: () => setState(() => selectedDifficulty = 'Dễ'),
              ),
              ReactionButton(
                icon: Icons.sentiment_neutral,
                label: 'Trung bình',
                color: Colors.orange,
                isSelected: selectedDifficulty == 'Trung bình',
                onTap: () =>
                    setState(() => selectedDifficulty = 'Trung bình'),
              ),
              ReactionButton(
                icon: Icons.sentiment_dissatisfied,
                label: 'Khó',
                color: Colors.red,
                isSelected: selectedDifficulty == 'Khó',
                onTap: () => setState(() => selectedDifficulty = 'Khó'),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ReactionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const ReactionButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: isSelected ? color : Colors.black, size: 32),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? color : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
