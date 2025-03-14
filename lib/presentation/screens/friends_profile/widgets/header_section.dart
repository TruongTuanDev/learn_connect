import 'package:flutter/material.dart';
import 'package:learn_connect/presentation/screens/friends_profile/widgets/user_profile_section.dart';
import 'package:learn_connect/presentation/screens/friends_profile/widgets/user_stats_section.dart';
import 'package:learn_connect/presentation/screens/friends_profile/widgets/action_buttons_section.dart';

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          boxShadow: [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 15, // Giảm blurRadius để phần không bị quá dày
              offset: Offset(2, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.only(top: 50, bottom: 15), // Giảm padding để làm phần mỏng hơn
        margin: const EdgeInsets.only(bottom: 15), // Giảm margin giữa các phần
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 15, left: 30), // Giảm margin
              width: 27,
              height: 20,
              child: Image.network(
                "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/7e94e89d-ab73-494f-aa8f-2c1dab2c8245",
                fit: BoxFit.fill,
              ),
            ),
            UserProfileSection(),
            UserStatsSection(),
            ActionButtonsSection(),
          ],
        ),
      ),
    );
  }
}
