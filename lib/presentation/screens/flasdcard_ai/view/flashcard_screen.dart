import 'package:flutter/material.dart';
import '../models/flashcard_model.dart';
import '../widgets/flashcard_widget.dart';

class FlashcardAIScreen extends StatefulWidget {
  @override
  _FlashcardScreenState createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardAIScreen> {
  late FlashCardItem flashcard;
  List<FlashCardItem> flashcards = [];
  bool isInitialized = false;
  final PageController _pageController = PageController();
  String selectedDifficulty = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isInitialized) {
      final args = ModalRoute.of(context)?.settings.arguments;

      if (args != null && args is Map) {
        flashcard = args['flashcard'] as FlashCardItem;
        flashcards = (args['items'] as List<dynamic>)
            .map((item) => item as FlashCardItem)
            .toList();
        isInitialized = true;
        setState(() {});
      } else {
        print('⚠️ Không nhận được dữ liệu từ trang trước!');
      }
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
      body: flashcards.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          SizedBox(height: 20),
          Text(
            flashcard.word.toUpperCase(),
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
                onTap: () =>
                    setState(() => selectedDifficulty = 'Khó'),
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
