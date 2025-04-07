import 'package:flutter/material.dart';

import 'package:learn_connect/presentation/screens/home/widgets/header_widget.dart';
import 'package:learn_connect/presentation/screens/home/widgets/navigation_widget.dart';
import 'package:learn_connect/presentation/screens/home/widgets/today_learning_widget.dart';
import 'package:learn_connect/presentation/screens/home/widgets/friend_activity_widget.dart';
import 'package:learn_connect/presentation/screens/home/widgets/connection_suggestion.dart';
import 'package:learn_connect/presentation/screens/home/widgets/post_widget.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView( // Đảm bảo có thể cuộn
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(),
              NavigationWidget(),
              TodayLearningWidget(),
              FriendActivityWidget(),
               ConnectionSuggestionWidget(), // Widget "Gợi ý kết nối"
              SizedBox(height: 10),
              PostWidget(
                username: "Trúc Cute",
                timeAgo: "20 phút trước",
                content: "Hôm nay mình đã học được cách sử dụng used to...",
                likes: 15,
                comments: 8,
                avatarUrl: "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/9c8e5c19-1c02-46bb-921c-1b9c853b4c5c",
              ),
              PostWidget(
                username: "Nguyễn B",
                timeAgo: "20 phút trước",
                content: "Ai có tài liệu về thì quá khứ hoàn thành không?",
                likes: 12,
                comments: 5,
                avatarUrl: "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/6a393e58-4b97-4fa9-bb22-7f982f00e5e0",
              ),
              SizedBox(height: 20), // Khoảng cách dưới cùng
            ],
          ),
        ),
      ),
    );
  }
}
