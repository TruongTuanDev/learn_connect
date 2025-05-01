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

  final List<Map<String, String>> users = [
    {
      'name': 'Lê Viết Toàn',
      'language': 'Tiếng Việt → Tiếng Anh',
      'age': '9',
      'image': 'assets/images/avartar.png',
    },
    {
      'name': 'John',
      'language': 'Tiếng Anh → Tiếng Nhật',
      'age': '10',
      'image': 'assets/images/phuc.jpg',
    },
    {
      'name': 'Nguyễn Thảo Nhi',
      'language': 'Tiếng Việt → Tiếng Hàn',
      'age': '12',
      'image': 'assets/images/tam.jpg',
    },
    {
      'name': 'David Kim',
      'language': 'Tiếng Hàn → Tiếng Anh',
      'age': '13',
      'image': 'assets/images/truc.jpg',
    },
    {
      'name': 'Linh Nguyễn',
      'language': 'Tiếng Việt → Tiếng Trung',
      'age': '11',
      'image': 'assets/images/tam.jpg',
    },
    {
      'name': 'Sakura Tanaka',
      'language': 'Tiếng Nhật → Tiếng Việt',
      'age': '14',
      'image': 'assets/images/avartar.jpg',
    },
    {
      'name': 'Tom',
      'language': 'Tiếng Anh → Tiếng Pháp',
      'age': '15',
      'image': 'assets/images/phuc.jpg',
    },
    {
      'name': 'Hoàng Minh',
      'language': 'Tiếng Việt → Tiếng Đức',
      'age': '13',
      'image': 'assets/images/truc.jpg',
    },
    {
      'name': 'Alice',
      'language': 'Tiếng Pháp → Tiếng Anh',
      'age': '10',
      'image': 'assets/images/tam.jpg',
    },
    {
      'name': 'Yuki',
      'language': 'Tiếng Nhật → Tiếng Hàn',
      'age': '12',
      'image': 'assets/images/phuc.jpg',
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
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        elevation: 0,
        title: Text(
          "Kết bạn học ngôn ngữ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
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
