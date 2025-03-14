// screens/flashcard_screen.dart
import 'package:flutter/material.dart';
import '../models/flashcard_model.dart';
import '../widgets/flashcard_widget.dart';

class FlashcardScreen extends StatefulWidget {
  @override
  _FlashcardScreenState createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  final List<Flashcard> flashcards = [
    Flashcard(front: "ABSENT (adjective) /ˈæbsənt/", back: "vắng mặt (vì đau ốm,...)Ví dụ:Most students were absent from school at least once (Hầu hết sinh viên đã vắng mặt ít nhất một lần)"),
    Flashcard(front: "ACCEPT (verb) /əkˈsept/", back: "nhận, chấp nhậnVí dụ:We accept payment by Visa Electron, Visa, Switch, Maestro, Mastercard, JCB, Solo, check or cash. (Chúng tôi chấp nhận thanh toán bằng thẻ Visa Electron, Visa, Switch, Maestro, Mastercard, JCB, Solo, séc hoặc tiền mặt.)"),
    Flashcard(front: "ACCOMMODATION (noun) /əˌkɒməˈdeɪʃən/", back: "chỗ trọ, chỗ ăn ở Ví dụ: I am not wealthy enough to afford first-class accommodation. (Tôi không đủ giàu để mua được chỗ ở hạng nhất.)"),
    Flashcard(front: "ACQUIRE (verb) /əˈkwaɪər/", back: "thu được, đạt được Ví dụ: He acquired the firm in 2008. (Ông đã có được công ty vào năm 2008.)"),
  ];

  final PageController _pageController = PageController();
  String selectedDifficulty = '';

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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleTextStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'TỪ VỰNG TIẾNG ANH VĂN PHÒNG',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                onTap: () => setState(() => selectedDifficulty = 'Trung bình'),
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
          Text(label, style: TextStyle(color: isSelected ? color : Colors.black, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
