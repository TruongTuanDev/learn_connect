import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 23),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF202244),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}