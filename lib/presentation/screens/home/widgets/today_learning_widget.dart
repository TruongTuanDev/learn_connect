import 'package:flutter/material.dart';
import 'package:learn_connect/presentation/screens/dictionary/view/DictionaryScreen.dart';
import 'package:learn_connect/routes/routes.dart';
import 'package:learn_connect/services/flashcard_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodayLearningWidget extends StatefulWidget {
  @override
  _TodayLearningState createState() => _TodayLearningState();
}

class _TodayLearningState extends State<TodayLearningWidget> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  bool isPasswordVisible = false;
  bool isLoading = false;

  final FlashcardService flashcardService = FlashcardService();

  Future<void> _getTopic() async {
    Navigator.pushNamed(context, AppRoutes.search);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xFFF3F3F3),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
      margin: const EdgeInsets.only(bottom: 37),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Học tập hôm nay",
            style: TextStyle(
              color: Color(0xFF202244),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildLearningButton(
                  context,
                  "FLASHCARDS",
                  Icons.menu_book	,
                      () => !isLoading ? _getTopic() : null,
                ),
                _buildLearningButton(
                  context,
                  "FLASHCARDS AI",
                  Icons.memory,
                      () => Navigator.pushNamed(context, AppRoutes.flascard_ai),
                ),
                _buildLearningButton(
                  context,
                  "LUYỆN NGHE",
                  Icons.headphones,
                      () => print("Nhấn vào LUYỆN NGHE"),
                ),
                _buildLearningButton(
                  context,
                  "ÔN TỪ VỰNG",
                  Icons.assignment,
                      () => Navigator.pushNamed(context, AppRoutes.vocabulary),
                ),
                _buildLearningButton(
                  context,
                  "TỪ ĐIỂN",
                  Icons.library_books,
                      () => Navigator.push(context, MaterialPageRoute(builder: (context) => DictionaryScreen()),
                      )
                ),
                // Thêm các button khác nếu cần
              ].map((e) => Padding(
                padding: const EdgeInsets.only(right: 12),
                child: e,
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningButton(BuildContext context, String text, IconData icon, VoidCallback? onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28, color: Colors.white),
          SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
