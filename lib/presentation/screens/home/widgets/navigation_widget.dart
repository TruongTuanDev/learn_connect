import 'package:flutter/material.dart';

class NavigationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xFFEEEEEE),
      ),
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 27, right: 4),
      margin: const EdgeInsets.only(bottom: 21),
      child: Row(
        children: [
          _buildNavItem("Trang chủ"),
          _buildNavItem("Tìm bạn bè"),
          _buildNavItem("Học tập"),
          _buildNavItem("Cộng đồng"),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title) {
    return InkWell(
      onTap: () {
        print('$title Pressed');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xFFFFC7C8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
        margin: const EdgeInsets.only(right: 25),
        child: Text(
          title,
          style: TextStyle(
            color: Color(0xFF202244),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
