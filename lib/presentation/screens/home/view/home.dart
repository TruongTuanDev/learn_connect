import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learn_connect/data/models/post.dart';
import 'package:learn_connect/presentation/screens/explore/view/ExploreScreen.dart';
import 'package:learn_connect/presentation/screens/moment/view/MomentsScreen.dart';
import 'package:learn_connect/routes/routes.dart';
import 'package:learn_connect/services/api_service.dart';
import 'package:learn_connect/presentation/screens/home/widgets/header_widget.dart';
import 'package:learn_connect/presentation/screens/home/widgets/navigation_widget.dart';
import 'package:learn_connect/presentation/screens/home/widgets/today_learning_widget.dart';
import 'package:learn_connect/presentation/screens/home/widgets/friend_activity_widget.dart';
import 'package:learn_connect/presentation/screens/home/widgets/connection_suggestion.dart';
import 'package:learn_connect/presentation/screens/home/widgets/post_widget.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Post>> _postsFuture;
  final TextEditingController _contentController = TextEditingController();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePageContent(),
    ExploreScreen(), // Giả sử bạn có một ExploreScreen
    MomentsScreen(), // Giả sử bạn có một MomentsScreen
    Text('Màn hình Thông báo'), // Placeholder
    Text('Màn hình Hồ sơ'),       // Placeholder
  ];

  @override
  void initState() {
    super.initState();
    _postsFuture = ApiService.fetchPosts();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
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
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.white,
        elevation: 10,
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTabItem(
                icon: Icons.home,
                label: "Trang chủ",
                isSelected: _currentIndex == 0,
                onTap: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              _buildTabItem(
                icon: Icons.explore,
                label: "Khám phá",
                isSelected: _currentIndex == 1,
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
              SizedBox(width: 40), // Khoảng trống cho FAB
              _buildTabItem(
                icon: Icons.notifications,
                label: "Thông báo",
                isSelected: _currentIndex == 2,
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
              ),
              _buildTabItem(
                icon: Icons.person,
                label: "Hồ sơ",
                isSelected: _currentIndex == 3,
                onTap: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.blueAccent : Colors.grey,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.blueAccent : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderWidget(),
          NavigationWidget(),
          TodayLearningWidget(),
          FriendActivityWidget(),
          ConnectionSuggestionWidget(),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}