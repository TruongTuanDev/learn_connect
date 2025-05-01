import 'package:flutter/material.dart';

class MomentsScreen extends StatefulWidget {
  @override
  _MomentsScreenState createState() => _MomentsScreenState();
}

class _MomentsScreenState extends State<MomentsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0; // cho bottom nav bar

    @override
    void initState() {
      super.initState();
      _tabController = TabController(length: 2, vsync: this);
    }

    @override
    void dispose() {
      _tabController.dispose();
      super.dispose();
    }
  // Dữ liệu giả để hiển thị danh sách các bài viết (moment) với nhiều ảnh
  final List<Map<String, dynamic>> _moments = [
      {
        'username': 'Mai',
        'images': [
          'assets/images/Content/7.jpg',
          'assets/images/Content/1.jpg',
        ],
        'profileImage': 'assets/images/Ava/7.jpg',
        'content': 'Chill cùng bạn bè cuối tuần!',
        'likes': 15,
        'comments': 5,
        'liked': false,
      },
      {
        'username': 'Lan',
        'images': [
          'assets/images/Content/4.jpg',
          'assets/images/Content/5.jpg',
          'assets/images/Content/6.jpg',
        ],
        'profileImage': 'assets/images/Ava/8.jpg',
        'content': 'Đi chơi biển đây! 🌊',
        'likes': 23,
        'comments': 7,
        'liked': true,
      },
      {
        'username': 'Hương',
        'images': [
          'assets/images/Content/8.jpg',
        ],
        'profileImage': 'assets/images/Ava/9.jpg',
        'content': 'Một ngày làm việc hiệu quả',
        'likes': 8,
        'comments': 1,
        'liked': false,
      },
      {
        'username': 'Thảo',
        'images': [
          'assets/images/Content/4.jpg',
          'assets/images/Content/5.jpg',
        ],
        'profileImage': 'assets/images/Ava/10.jpg',
        'content': 'Ăn tối ngon quá!',
        'likes': 12,
        'comments': 4,
        'liked': false,
      },
      {
        'username': 'Nam',
        'images': [
          'assets/images/Content/3.jpg',
          'assets/images/Content/5.jpg',
          'assets/images/Content/8.jpg',

        ],
        'profileImage': 'assets/images/Ava/1.jpg',
        'content': 'Đá bóng cùng anh em',
        'likes': 18,
        'comments': 6,
        'liked': true,
      },
      {
        'username': 'Tuấn',
        'images': [
          'assets/images/Content/1.jpg',
        ],
        'profileImage': 'assets/images/Ava/2.jpg',
        'content': 'Làm việc tại quán cà phê',
        'likes': 5,
        'comments': 0,
        'liked': false,
      },
      {
        'username': 'Hùng',
        'images': [
          'assets/images/Content/10.jpg',
          'assets/images/Content/9.jpg',
        ],
        'profileImage': 'assets/images/Ava/3.jpg',
        'content': 'Du lịch Đà Lạt',
        'likes': 25,
        'comments': 9,
        'liked': false,
      },
      {
        'username': 'Đức',
        'images': [
          'assets/images/Content/3.jpg',
          'assets/images/Content/7.jpg',
          'assets/images/Content/8.jpg',
        ],
        'profileImage': 'assets/images/Ava/4.jpg',
        'content': 'Chụp ảnh cùng team',
        'likes': 14,
        'comments': 3,
        'liked': true,
      },
      {
        'username': 'Quang',
        'images': [
          'assets/images/Content/10.jpg',
        ],
        'profileImage': 'assets/images/Ava/5.jpg',
        'content': 'Ngày mới tốt lành',
        'likes': 7,
        'comments': 2,
        'liked': false,
      },
      {
        'username': 'Long',
        'images': [
          'assets/images/Content/4.jpg',
          'assets/images/Content/8.jpg',
        ],
        'profileImage': 'assets/images/Ava/6.jpg',
        'content': 'Chạy bộ buổi sáng',
        'likes': 9,
        'comments': 1,
        'liked': false,
      }
    // Thêm các bài viết giả vào đây
  ];

  // Hàm thay đổi trạng thái like
  void _toggleLike(int index) {
    setState(() {
      _moments[index]['liked'] = !_moments[index]['liked'];
      _moments[index]['likes'] += _moments[index]['liked'] ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blueAccent,
          tabs: [
            Tab(text: 'Dành cho bạn'),
            Tab(text: 'Đang theo dõi'),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
       body: TabBarView(
      controller: _tabController,
      children: [
        Center(
            child: ListView.builder(
              itemCount: _moments.length,
              itemBuilder: (context, index) {
                var moment = _moments[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Bo góc của card
                  ),
                  elevation: 5, // Thêm bóng đổ cho card
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row chứa ảnh đại diện và tên người đăng
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 18,  // Kích thước ảnh đại diện nhỏ hơn
                              backgroundImage: AssetImage(moment['profileImage']),
                            ),
                            SizedBox(width: 10),
                            Text(
                              moment['username'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.teal, // Màu tên
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Nội dung bài đăng
                        Text(
                          moment['content'],
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        // Hiển thị nhiều ảnh trong bài đăng
                        moment['images'] != null && moment['images'].isNotEmpty
                            ? Container(
                          height: 200, // Chiều cao của container chứa ảnh
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal, // Di chuyển theo chiều ngang
                            itemCount: moment['images'].length,
                            itemBuilder: (context, imageIndex) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    moment['images'][imageIndex],
                                    width: 150, // Chiều rộng ảnh
                                    height: 200, // Chiều cao ảnh
                                    fit: BoxFit.contain, // Đảm bảo hình ảnh hiển thị toàn bộ mà không bị cắt
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                            : Container(),
                        SizedBox(height: 10),
                        // Tương tác (Like và Comment)
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                moment['liked'] ? Icons.thumb_up : Icons.thumb_up_alt,
                                color: moment['liked'] ? Colors.blue : Colors.grey,
                              ),
                              onPressed: () => _toggleLike(index),
                            ),
                            Text('${moment['likes']} Likes'),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.comment, color: Colors.grey),
                              onPressed: () {
                                // Mở phần bình luận khi người dùng nhấn vào biểu tượng comment
                                _showCommentsDialog(context, index);
                              },
                            ),
                            Text('${moment['comments']} Comments'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ),
        Center(child: Text('Nội dung đang theo dõi')),
      ],
    ),

    );
  }

  // Hàm hiển thị phần bình luận
  void _showCommentsDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Comments'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                // Hiển thị danh sách bình luận (ở đây tôi chỉ hiển thị bình luận giả)
                for (int i = 0; i < _moments[index]['comments']; i++)
                  ListTile(
                    title: Text('User ${(i + 1)}: Great post!'),
                  ),
                // Ô nhập bình luận mới
                TextField(
                  decoration: InputDecoration(hintText: 'Add a comment...'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Đóng dialog
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
