import 'package:flutter/material.dart';
import 'package:learn_connect/routes/routes.dart';

class TodayLearningWidget extends StatelessWidget {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildLearningButton(
                context,
                "FLASHCARDS",
                Icons.view_carousel,
                    () => Navigator.pushNamed(context, AppRoutes.flascard),
                    // () => print("Nhấn vào LUYỆN NGHE")
              ),
              _buildLearningButton(
                context,
                "LUYỆN NGHE",
                Icons.headphones,
                    () => print("Nhấn vào LUYỆN NGHE"),
              ),
              _buildLearningButton(
                context,
                "LUYỆN ĐỌC",
                Icons.menu_book,
                    () => print("Nhấn vào LUYỆN ĐỌC"),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLearningButton(BuildContext context, String text, IconData icon, VoidCallback onTap) {
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
