import 'package:flutter/material.dart';

class ConnectionSuggestionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Gợi ý kết nối",
                  style: TextStyle(
                    color: Color(0xFF202244),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Xem tất cả",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Danh sách người dùng
          Column(
            children: [
              _buildUserItem(
                "assets/images/avartar.png",
                "Tuấn Trương",
              ),
              _buildUserItem(
                "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/6a393e58-4b97-4fa9-bb22-7f982f00e5e0",
                "Peter",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserItem(String imageUrl, String name) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Ảnh đại diện bo tròn
          ClipOval(
            child: Image.network(
              imageUrl,
              width: 51,
              height: 51,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 51,
                height: 51,
                color: Colors.grey[300],
                child: Icon(Icons.person, color: Colors.grey[600]),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Tên người dùng
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Nút kết bạn
          ElevatedButton(
            onPressed: () {
              // TODO: Thêm logic gửi yêu cầu kết bạn
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: Text(
              "Kết bạn",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
