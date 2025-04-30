import 'package:flutter/material.dart';
import 'package:learn_connect/presentation/screens/search_ai/PartnerFinderApp.dart';
import 'package:learn_connect/presentation/screens/swipe_friend/view/swipe_friend.dart';
import 'package:learn_connect/routes/routes.dart';

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
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildNavItem(context, "Trang chủ"),
            _buildNavItem(context, "Tìm bạn bè"),
            _buildNavItem(context, "Học tập"),
            _buildNavItem(context, "Cộng đồng"),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String title) {

    return InkWell(
      onTap: () {
        if (title == "Tìm bạn bè") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SwipePage()),
          );
        } else if(title == "Cộng đồng") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PartnerFinderScreen()),
          );
        }else if(title == "Tìm bạn bè") {
          print('$title Pressed');
        }
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
