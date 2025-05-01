import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecommendedFriendsScreen extends StatefulWidget {
  final String idUser;

  const RecommendedFriendsScreen({Key? key, required this.idUser}) : super(key: key);

  @override
  _RecommendedFriendsScreenState createState() => _RecommendedFriendsScreenState();
}

class _RecommendedFriendsScreenState extends State<RecommendedFriendsScreen> {
  List<dynamic> friends = [];
  bool isLoading = true;
  final Set<String> sentRequests = {}; // Lưu những người đã gửi lời mời

  @override
  void initState() {
    super.initState();
    fetchRecommendedFriends();
  }

  Future<void> fetchRecommendedFriends() async {
    try {
      final response = await http.get(
        Uri.parse('http://your-node-server.com/api/recommend-friends?id_user=${widget.idUser}'),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'success') {
          setState(() {
            friends = jsonResponse['friends'];
            isLoading = false;
          });
        }
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  String getAvatarUrl(String idUser) {
    // Dùng id_user để tạo avatar tạm (ví dụ từ dịch vụ avatar.io hoặc tạo theo màu riêng)
    return 'https://api.dicebear.com/7.x/identicon/svg?seed=$idUser';
  }

  void sendFriendRequest(String friendId) {
    // TODO: Gọi API gửi lời mời thật nếu cần
    setState(() {
      sentRequests.add(friendId);
    });
  }

  Widget buildSkeletonLoader() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gợi ý bạn bè'),
      ),
      body: isLoading
          ? buildSkeletonLoader()
          : friends.isEmpty
          ? const Center(child: Text('Không tìm thấy bạn bè phù hợp'))
          : ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          final friend = friends[index];
          final friendId = friend['id_user'];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(getAvatarUrl(friendId)),
                ),
                title: Text(
                  friend['username'] ?? 'Không tên',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Độ phù hợp: ${(friend['score'] * 100).toStringAsFixed(1)}%'),
                trailing: ElevatedButton(
                  onPressed: sentRequests.contains(friendId)
                      ? null
                      : () {
                    sendFriendRequest(friendId);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: sentRequests.contains(friendId) ? Colors.grey : Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(sentRequests.contains(friendId) ? 'Đã gửi' : 'Kết bạn'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
