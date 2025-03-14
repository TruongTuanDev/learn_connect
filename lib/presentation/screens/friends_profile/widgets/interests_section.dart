import 'package:flutter/material.dart';
import 'package:learn_connect/presentation/screens/friends_profile/widgets/interest_item.dart';

class InterestsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: const EdgeInsets.only(bottom: 14, left: 36, right: 36),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InterestItem(title: "Âm nhạc"),
            InterestItem(title: "Phim ảnh"),
            InterestItem(title: "Du lịch"),
          ],
        ),
      ),
    );
  }
}
