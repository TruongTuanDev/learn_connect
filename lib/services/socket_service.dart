import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_connect/config/app_config.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final socketServiceProvider = Provider<SocketService>((ref) {
  final service = SocketService(ref);
  ref.onDispose(() => service.dispose()); // Tự động dispose khi Provider bị hủy
  return service;
});

final onlineUsersProvider = StateProvider<List<String>>((ref) => []);

class SocketService {
  final Ref ref;
  late final IO.Socket socket;
  bool _isConnected = false;

  SocketService(this.ref) {
    _initSocket();
  }

  void _initSocket() {
    socket = IO.io(
      'http://localhost:8080',
      IO.OptionBuilder()
          .setTransports(['websocket']) // Chỉ dùng WebSocket
          .disableAutoConnect() // Tắt kết nối tự động
          .enableReconnection() // Tự động kết nối lại nếu mất kết nối
          .setReconnectionDelay(1000) // Thử lại sau 1 giây
          .setReconnectionAttempts(5) // Thử tối đa 5 lần
          .build(),
    );

    _setupEventListeners();
    socket.connect();
  }

  void _setupEventListeners() {
    socket.on('connect', (_) {
      _isConnected = true;
      socket.emit('join', {'userId': AppConfig.userId});
    });

    socket.on('disconnect', (_) => _isConnected = false);

    socket.on('online-users', (data) {
      if (data is List) {
        ref.read(onlineUsersProvider.notifier).state = List<String>.from(data);
      }
    });

    socket.on('error', (error) => print('Socket error: $error'));
  }

  void sendMessage(String receiverId, String content) {
    if (!_isConnected) {
      print('Warning: Socket not connected!');
      return;
    }

    socket.emit('send-private-message', {
      'senderId': AppConfig.userId,
      'receiverId': receiverId,
      'content': content,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  void listenToMessages(Function(Map<String, dynamic>) onMessageReceived) {
    socket.off('receive-private-message'); // Xóa listener cũ trước khi thêm mới
    socket.on('receive-private-message', (data) {
      if (data is Map) {
        onMessageReceived(Map<String, dynamic>.from(data));
      }
    });
  }

  void dispose() {
    socket.off('connect');
    socket.off('disconnect');
    socket.off('online-users');
    socket.off('receive-private-message');
    socket.disconnect();
    socket.close();
  }
}