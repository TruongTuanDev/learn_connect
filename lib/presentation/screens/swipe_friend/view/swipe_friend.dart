import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../widgets/user_card.dart';

class SwipePage extends StatefulWidget {
  @override
  _SwipePageState createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  List<SwipeItem> _swipeItems = [];
  late MatchEngine _matchEngine;

  List<Map<String, String>> users = [
    {
      'name': 'Maria',
      'language': 'Tây Ban Nha → Tiếng Việt',
      'age': 9.toString(),
      'image': 'https://i.imgur.com/0y8Ftya.jpg'
    },
    {
      'name': 'John',
      'language': 'Tiếng Anh → Tiếng Nhật',
      'age': 10.toString(),
      'image': 'https://i.imgur.com/QCNbOAo.png'
    },
  ];

  List<Map<String, String>> favorites = [];

  @override
  void initState() {
    for (var user in users) {
      _swipeItems.add(
        SwipeItem(
          content: user,
          likeAction: () {
            print("Thích ${user['name']}");
            favorites.add(user);
          },
          nopeAction: () {
            print("Bỏ qua ${user['name']}");
          },
        ),
      );
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kết bạn học ngôn ngữ")),
      body: Center(
        child: SwipeCards(
          matchEngine: _matchEngine,
          itemBuilder: (context, index) {
            return UserCard(user: users[index]);
          },
          onStackFinished: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Hết người rồi, quay lại sau nhé!")),
            );
          },
          upSwipeAllowed: false,
          fillSpace: true,
        ),
      ),
    );
  }
}
