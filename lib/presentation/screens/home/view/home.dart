import 'package:flutter/material.dart';
import 'package:learn_connect/data/models/post.dart';
import 'package:learn_connect/services/api_service.dart';
import 'package:learn_connect/presentation/screens/home/widgets/header_widget.dart';
import 'package:learn_connect/presentation/screens/home/widgets/navigation_widget.dart';
import 'package:learn_connect/presentation/screens/home/widgets/today_learning_widget.dart';
import 'package:learn_connect/presentation/screens/home/widgets/friend_activity_widget.dart';
import 'package:learn_connect/presentation/screens/home/widgets/connection_suggestion.dart';
import 'package:learn_connect/presentation/screens/home/widgets/post_widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = ApiService.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(),
              NavigationWidget(),
              TodayLearningWidget(),
              FriendActivityWidget(),
              ConnectionSuggestionWidget(),
              SizedBox(height: 10),

              // 👉 Bài đăng lấy từ API
              FutureBuilder<List<Post>>(
                future: _postsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Lỗi: ${snapshot.error}'));
                  }

                  final posts = snapshot.data!;
                  return Column(
                    children: posts.map((p) {
                      return PostWidget(
                        username: p.username,
                        timeAgo: p.timeAgo,
                        content: p.content,
                        likes: p.likes,
                        comments: p.comments,
                        avatarUrl: p.avatarUrl,
                        postId: p.id ?? '', // Gán đúng ID từ DB (nullable-safe)
                      );
                    }).toList(),
                  );
                },
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
