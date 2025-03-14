import 'package:flutter/material.dart';
class InterestItem extends StatelessWidget {
  final String title;

  const InterestItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          print('Pressed');
        },
        child: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: Color(0xFFE8F1FF),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Color(0xFF202244),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}