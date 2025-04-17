import 'package:learn_connect/config/app_config.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

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