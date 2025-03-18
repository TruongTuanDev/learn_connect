import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_connect/presentation/screens/conversation/messenger//message_model.dart';

class MessagingListNotifier extends StateNotifier<List<Messenger>> {
  MessagingListNotifier() : super([]){
    loadChats();
  }

  final MessengerModel _messageModel = MessengerModel();

  Future<void> loadChats() async {
    state = await _messageModel.fetchChats();
  }
}

// Provider cho MessagingListNotifier
final messagingListProvider =
StateNotifierProvider<MessagingListNotifier, List<Messenger>>(
      (ref) => MessagingListNotifier(),
);
