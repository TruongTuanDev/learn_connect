import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F8FE),
      padding: const EdgeInsets.symmetric(vertical: 20), // Giảm padding
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20), // Thêm padding ngang để cân đối
        child: Row(
          children: [
            Image.network(
              "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/d74f1e29-b0fa-4be8-a358-dd5dba7d014f",
              width: 24,
              height: 18,
              fit: BoxFit.fill,
            ),
            const SizedBox(width: 10), // Khoảng cách nhỏ giữa icon và text
            const Text(
              "Thông báo",
              style: TextStyle(
                color: Color(0xFF202244),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
