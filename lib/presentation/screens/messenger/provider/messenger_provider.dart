import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:learn_connect/config/app_config.dart';
import 'package:learn_connect/presentation/screens/messenger/model/message_model.dart';

class MessengerListNotifier extends StateNotifier<List<Messenger>> {
  MessengerListNotifier() : super([]) {
    fetchMessengerList();
  }

  final _dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl)); // Đổi IP nếu test thật

  Future<void> fetchMessengerList() async {
    try {
      final response = await _dio.get('/api/messages/chat-list', queryParameters: {
        'userId': AppConfig.userId // 🔁 user hiện tại
      });

      final List data = response.data;
      state = data.map((json) => Messenger.fromJson(json)).toList();
    } catch (e) {
      print('❌ Lỗi khi load danh sách tin nhắn: $e');
    }
  }
}

final messagingListProvider =
StateNotifierProvider<MessengerListNotifier, List<Messenger>>(
      (ref) => MessengerListNotifier(),
);
