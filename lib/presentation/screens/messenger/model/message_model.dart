import 'package:dio/dio.dart';
import 'package:timeago/timeago.dart' as timeago;

class Messenger {
  final String id;
  final String avatarUrl;
  final String name;
  final String message;
  final String time;
  final int unread;

  const Messenger({
    required this.id,
    required this.avatarUrl,
    required this.name,
    required this.message,
    required this.time,
    required this.unread,
  });

  factory Messenger.fromJson(Map<String, dynamic> json) {
    final timestampStr = json['timestamp'] as String?;
    final timestamp = timestampStr != null ? DateTime.tryParse(timestampStr) : null;
    final formattedTime = timestamp != null ? timeago.format(timestamp) : 'Chưa có tin nhắn';

    return Messenger(
      id: json['otherUserId'] as String,
      avatarUrl: "https://ui-avatars.com/api/?name=${json['username']}",
      name: json['username'] as String,
      message: json['lastMessage'] as String? ?? '',
      time: formattedTime,
      unread: 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'avatarUrl': avatarUrl,
    'name': name,
    'message': message,
    'time': time,
    'unread': unread,
  };
}



class MessengerModel {
  final List<Messenger> mockChatList = [
    Messenger(
      id: "tam",
      avatarUrl: "https://th.bing.com/th/id/OIP.w65TVIDbyX--uD5dgpOCDQ"
          "HaFj?w=288&h=216&c=7&r=0&o=5&dpr=1.3&pid=1.7",
      name: "Nguyễn Tâm",
      message: "Học bài chưa?",
      time: "14:59",
      unread: 3,
    ),
    Messenger(
      id: "phuc",
      avatarUrl: "https://th.bing.com/th/id/OIP.w65TVIDbyX--uD5dgpOCDQ"
          "HaFj?w=288&h=216&c=7&r=0&o=5&dpr=1.3&pid=1.7",
      name: "Nguyễn Phuc",
      message: "Nhắc học quá",
      time: "06:35",
      unread: 2,
    ),
    Messenger(
      id: "tuan",
      avatarUrl: "https://th.bing.com/th/id/OIP.w65TVIDbyX--uD5dgpOCDQ"
          "HaFj?w=288&h=216&c=7&r=0&o=5&dpr=1.3&pid=1.7",
      name: "Nguyễn C",
      message: "Buồn ngủ quá",
      time: "08:10",
      unread: 0,
    ),
    Messenger(
      id: "d",
      avatarUrl: "https://th.bing.com/th/id/OIP.w65TVIDbyX--uD5dgpOCDQ"
          "HaFj?w=288&h=216&c=7&r=0&o=5&dpr=1.3&pid=1.7",
      name: "Nguyễn D",
      message: "Đi ngủ đi",
      time: "21:07",
      unread: 5,
    ),
  ];

  final dio = Dio();

  Future<List<Messenger>> fetchChats() async {
    /*final response = await dio.get("path");

    if(response.statusCode == 200){
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => ChatMessage.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load chat messages');
    }*/
    return List<Messenger>.from(mockChatList);
  }
}
