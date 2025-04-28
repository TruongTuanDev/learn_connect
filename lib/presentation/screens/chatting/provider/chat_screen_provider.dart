import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_connect/config/app_config.dart';
import 'package:learn_connect/data/models/message_model.dart';
import 'package:learn_connect/services/message_service.dart';
import 'package:learn_connect/services/socket_service.dart';

class ChatNotifier extends StateNotifier<List<Message>> {
  final SocketService socketService;
  final String receivedId;
  final MessageService messageService;

  ChatNotifier({
    required this.socketService,
    required this.receivedId,
    required this.messageService
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
    final messages = await messageService.fetchMessages(AppConfig.userId, this.receivedId);
    state = messages;
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

final socketServiceProvider = Provider<SocketService>((ref) {
  final socketService = SocketService(ref);
  ref.onDispose(() {
    socketService.dispose();
  });
  return socketService;
});


final chatMessagesProvider = StateNotifierProvider.family<ChatNotifier, List<Message>, String>((ref, receivedId) {
  final socketService = ref.watch(socketServiceProvider);
  return ChatNotifier(
    socketService: socketService,
    receivedId: receivedId,
    messageService: MessageService(),
  );
});
