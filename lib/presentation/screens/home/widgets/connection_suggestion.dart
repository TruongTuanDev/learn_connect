import 'package:flutter/material.dart';
import 'package:learn_connect/config/app_config.dart';

import '../../../../services/add_friend.dart';

class ConnectionSuggestionWidget extends StatefulWidget {
  const ConnectionSuggestionWidget({super.key});

  @override
  State<ConnectionSuggestionWidget> createState() => _ConnectionSuggestionWidgetState();
}

class _ConnectionSuggestionWidgetState extends State<ConnectionSuggestionWidget> {
  List<Map<String, dynamic>> suggestions = List.from(AppConfig.friendSuggestions); // Copy dữ liệu ban đầu

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
                  "Lời mời kết bạn",
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
            children: suggestions.map((friend) {
              final id_user = friend['id_user'] ?? '';
              final id_friend = friend['id_friend'] ?? '';
              final avatar = friend['avatar'] ?? '';
              final name = friend['name_friend'] ?? '';

              return _buildUserItem(avatar, name, id_user, id_friend);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildUserItem(String imageUrl, String name, String id_user, String id_friend) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
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
          ElevatedButton(
            onPressed: () async {
              setState(() {
                suggestions.removeWhere((item) => item['id_friend'] == id_friend);
              });

              String result = await AddFriendService().removeFriend(
                idUser: AppConfig.userId,
                idFriend: id_friend,
              );
              print('✅ Phản hồi: $result');
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
              "Chấp nhận",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
