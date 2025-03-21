import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

@immutable
class Messenger {
  final String avatarUrl;
  final String name;
  final String message;
  final String time;
  final int unread;

  const Messenger({
    required this.avatarUrl,
    required this.name,
    required this.message,
    required this.time,
    required this.unread,
  });

  Map<String, dynamic> toJson() => {
    'avatarUrl': avatarUrl,
    'name': name,
    'message': message,
    'time': time,
    'unread': unread,
  };

  factory Messenger.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'avatarUrl': String avatarUrl,
      'name': String name,
      'message': String message,
      'time': String time,
      'unread': int unread
      } =>
          Messenger(
            avatarUrl: avatarUrl,
            name: name,
            message: message,
            time: time,
            unread: unread,
          ),
      _ => throw const FormatException('Failed to parse chat message')
    };
  }
}

class MessengerModel {
  final List<Messenger> mockChatList = [
    Messenger(
      avatarUrl: "https://th.bing.com/th/id/OIP.w65TVIDbyX--uD5dgpOCDQ"
          "HaFj?w=288&h=216&c=7&r=0&o=5&dpr=1.3&pid=1.7",
      name: "Nguyễn A",
      message: "Học bài chưa?",
      time: "14:59",
      unread: 3,
    ),
    Messenger(
      avatarUrl: "https://th.bing.com/th/id/OIP.w65TVIDbyX--uD5dgpOCDQ"
          "HaFj?w=288&h=216&c=7&r=0&o=5&dpr=1.3&pid=1.7",
      name: "Nguyễn B",
      message: "Nhắc học quá",
      time: "06:35",
      unread: 2,
    ),
    Messenger(
      avatarUrl: "https://th.bing.com/th/id/OIP.w65TVIDbyX--uD5dgpOCDQ"
          "HaFj?w=288&h=216&c=7&r=0&o=5&dpr=1.3&pid=1.7",
      name: "Nguyễn C",
      message: "Buồn ngủ quá",
      time: "08:10",
      unread: 0,
    ),
    Messenger(
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
