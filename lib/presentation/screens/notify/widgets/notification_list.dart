import 'package:flutter/material.dart';
import 'package:learn_connect/presentation/screens/notify/widgets/notification_item.dart';
import 'package:learn_connect/presentation/screens/notify/widgets/section_title.dart';
class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        margin: const EdgeInsets.only(bottom: 30, left: 34, right: 34),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: "Today"),
            NotificationItem(
              imageUrl: "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/15277603-f731-404f-bc4d-2822c922f3a3",
              text: "Nguyễn A đã đồng ý kết bạn",
            ),
            NotificationItem(
              imageUrl: "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/04f4a7e1-0673-445b-a992-acc42f950cf4",
              text: "Hôm nay học bài mới",
            ),
            NotificationItem(
              imageUrl: "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/ce24c24a-ec8c-4ce3-bffe-0d123e559d2b",
              text: "Tiếp tục ôn FlashCards",
            ),
          ],
        ),
      ),
    );
  }
}
