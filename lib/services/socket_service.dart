import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_connect/config/app_config.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  final Ref ref;
  late final IO.Socket socket;

  SocketService(this.ref) {
    socket = IO.io(
      AppConfig.socketServerUrl,
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      },
    );

    socket.connect();

    socket.on('connect', (_) {
      socket.emit('join', {'userId': AppConfig.userId});
    });

    socket.on('online-users', (data) {
      if (data is List) {
        ref.read(onlineUsersProvider.notifier).state =
        List<String>.from(data); // Update provider
      }
    });
  }

  void sendMessage(String receiverId, String content) {
    socket.emit('send-private-message', {
      'senderId': AppConfig.userId,
      'receiverId': receiverId,
      'content': content,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  void listenToMessages(Function(Map<String, dynamic>) onMessageReceived) {
    socket.on('receive-private-message', (data) {
      onMessageReceived(Map<String, dynamic>.from(data));
    });
  }

  void dispose() {
    socket.dispose();
  }
}

final onlineUsersProvider = StateProvider <List<String>>((ref) => []);
