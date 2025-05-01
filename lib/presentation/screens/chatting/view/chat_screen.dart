import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_connect/config/app_config.dart';
import 'package:learn_connect/data/models/message_model.dart';
import 'package:learn_connect/presentation/screens/chatting/provider/chat_screen_provider.dart';
import 'package:learn_connect/presentation/screens/chatting/widgets/input_field.dart';
import 'package:learn_connect/presentation/screens/chatting/widgets/message_bubble.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String receivedId;
  final String receiverName;

  const ChatScreen({
    Key? key,
    required this.receivedId,
    required this.receiverName,
  }) : super(key: key);

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatMessagesProvider(widget.receivedId));

    ref.listen<List<Message>>(chatMessagesProvider(widget.receivedId), (
      previous,
      next,
    ) {
      if (next != previous) {
        _scrollToBottom();
      }
    });
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("assets/images/none_avatar.png"),
            ),
            SizedBox(width: 8,),
            Text(
              widget.receiverName,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isMe = msg.senderId == AppConfig.userId;
                return MessageBubble(isSentByMe: isMe, message: msg.content);
              },
            ),
          ),
          InputField(controller: _controller, onSend: _sendMessage),
        ],
      ),
    );
  }

  void _sendMessage() {
    final msg = _controller.text.trim();
    if (msg.isNotEmpty) {
      ref
          .read(chatMessagesProvider(widget.receivedId).notifier)
          .sendMessage(msg);
      _controller.clear();
    }
  }
}
