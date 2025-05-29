import 'package:dio/dio.dart';
import 'package:learn_connect/data/models/message_model.dart';

class MessageService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://172.20.10.9:8080"));

  Future<List<Message>> fetchMessages(
    String senderId,
    String receiverId,
  ) async {
    try {
      Response response = await _dio.get(
        "/api/messages",
        queryParameters: {"senderId": senderId, "receiverId": receiverId},
      );

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => Message.fromJson(json))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
