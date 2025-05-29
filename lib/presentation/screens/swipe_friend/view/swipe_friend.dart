import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_connect/presentation/screens/home/widgets/custom_bottom_navigation.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../widgets/user_card.dart';

class SwipePage extends StatefulWidget {
  @override
  _SwipePageState createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  List<SwipeItem> _swipeItems = [];
  late MatchEngine _matchEngine;
  final TextEditingController _contentController = TextEditingController();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  int _currentIndex = 0;
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  final List<Map<String, String>> users = [
    {
      'name': 'Lê Viết Toàn',
      'language': 'Tiếng Việt → Tiếng Anh',
      'age': '22',
      'image': 'assets/images/Ava/1.jpg',
    },
    {
      'name': 'John',
      'language': 'Tiếng Anh → Tiếng Nhật',
      'age': '19',
      'image': 'assets/images/Ava/2.jpg',
    },
    {
      'name': 'Nguyễn Thảo Nhi',
      'language': 'Tiếng Việt → Tiếng Hàn',
      'age': '21',
      'image': 'assets/images/Ava/7.jpg',
    },
    {
      'name': 'David Kim',
      'language': 'Tiếng Hàn → Tiếng Anh',
      'age': '23',
      'image': 'assets/images/Ava/8.jpg',
    },
    {
      'name': 'Linh Nguyễn',
      'language': 'Tiếng Việt → Tiếng Trung',
      'age': '26',
      'image': 'assets/images/Ava/9.jpg',
    },
    {
      'name': 'Sakura Tanaka',
      'language': 'Tiếng Nhật → Tiếng Việt',
      'age': '17',
      'image': 'assets/images/Ava/10.jpg',
    },
    {
      'name': 'Tom',
      'language': 'Tiếng Anh → Tiếng Pháp',
      'age': '19',
      'image': 'assets/images/Ava/4.jpg',
    },
    {
      'name': 'Hoàng Minh',
      'language': 'Tiếng Việt → Tiếng Đức',
      'age': '25',
      'image': 'assets/images/Ava/5.jpg',
    },
    {
      'name': 'Alice',
      'language': 'Tiếng Pháp → Tiếng Anh',
      'age': '24',
      'image': 'assets/images/Ava/6.jpg',
    },
    {
      'name': 'Yuki',
      'language': 'Tiếng Nhật → Tiếng Hàn',
      'age': '20',
      'image': 'assets/images/Ava/3.jpg',
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
        backgroundColor: Colors.blueAccent,
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
      floatingActionButton: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel: '',
              barrierColor: Colors.black.withOpacity(0.5),
              transitionDuration: Duration(milliseconds: 300),
              pageBuilder: (context, anim1, anim2) {
                return Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Tạo bài viết mới',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: _contentController,
                              decoration: InputDecoration(
                                hintText: 'Bạn đang nghĩ gì?',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              maxLines: 3,
                            ),
                            SizedBox(height: 10),
                            if (_selectedImage != null)
                              Container(
                                height: 150,
                                width: double.infinity,
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: FileImage(_selectedImage!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            Row(
                              children: [
                                ElevatedButton.icon(
                                  onPressed: _pickImage,
                                  icon: Icon(Icons.image),
                                  label: Text('Chọn ảnh'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[300],
                                    foregroundColor: Colors.black,
                                  ),
                                ),
                                Spacer(),
                                TextButton(
                                  onPressed: () {
                                    _contentController.clear();
                                    _selectedImage = null;
                                    Navigator.pop(context);
                                  },
                                  child: Text('Hủy'),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    print('Nội dung: ${_contentController.text}');
                                    print('Ảnh: ${_selectedImage?.path}');
                                    _contentController.clear();
                                    _selectedImage = null;
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                  ),
                                  child: Text('Đăng'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              transitionBuilder: (context, anim1, anim2, child) {
                return ScaleTransition(
                  scale: CurvedAnimation(
                    parent: anim1,
                    curve: Curves.easeOutBack,
                  ),
                  child: child,
                );
              },
            );
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(Icons.add, size: 32, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // Thêm bottomNavigationBar vào đây
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _currentIndex,
        onTabSelected: (index) {
          setState(() {
            _currentIndex = index;
            // Thêm logic chuyển trang tại đây nếu cần
          });
        },
      ),
    );
  }
}