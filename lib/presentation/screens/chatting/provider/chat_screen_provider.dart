import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_connect/config/app_config.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Message {
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime timestamp;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      content: json['content'],
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'senderId': senderId,
    'receiverId': receiverId,
    'content': content,
    'timestamp': timestamp.toIso8601String(),
  };
}

class SocketService {
  late final IO.Socket socket;

  SocketService() {
    socket = IO.io(
      AppConfig.socketServerUrl,
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      },
    );

    socket.connect();

    socket.on('connect', (_) {
      // Khi kết nối thành công, gửi event đăng ký (join) với senderId
      socket.emit('join', {'userId': AppConfig.userId});
    });
  }

  // Gửi tin nhắn đến một người nhận xác định
  void sendMessage(String receiverId, String content) {
    socket.emit('send-private-message', {
      'senderId': AppConfig.userId,
      'receiverId': receiverId,
      'content': content,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  // Lắng nghe sự kiện tin nhắn từ server
  void listenToMessages(Function(Map<String, dynamic>) onMessageReceived) {
    socket.on('receive-private-message', (data) {
      onMessageReceived(Map<String, dynamic>.from(data));
    });
  }

  void dispose() {
    socket.dispose();
  }
}

class ChatNotifier extends StateNotifier<List<Message>> {
  final SocketService socketService;
  final String receivedId;

  ChatNotifier({
    required this.socketService,
    required this.receivedId,
  }) : super([]) {
    _fetchMessages();
    // Lắng nghe tin nhắn từ server
    socketService.listenToMessages((data) {
      final message = Message.fromJson(data);
      print(message.content);
      // Chỉ cập nhật state nếu tin nhắn thuộc cuộc trò chuyện 1-1 hiện thời
      if ((message.senderId == receivedId &&
          message.receiverId == AppConfig.userId) ||
          (message.senderId == AppConfig.userId &&
              message.receiverId == receivedId)) {
        print("True");
        state = [...state, message];
      }
    });
  }
  Future<void> _fetchMessages() async {
    /*final messages = await ChatRepository().getMessagesForChat(receivedId);
    state = messages;*/
  }
  // Hàm gửi tin nhắn (với nội dung truyền vào)
  void sendMessage(String content) {
    socketService.sendMessage(receivedId, content);
    final newMessage = Message(
      senderId: AppConfig.userId,
      receiverId: receivedId,
      content: content,
      timestamp: DateTime.now(),
    );
    state = [...state, newMessage];
  }

  @override
  void dispose() {
    socketService.dispose();
    super.dispose();
  }
}

final chatMessagesProvider = StateNotifierProvider.family<ChatNotifier, List<Message>, String>((ref, receivedId) {
  final socketService = SocketService();
  return ChatNotifier(
    socketService: socketService,
    receivedId: receivedId
  );
});