import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_connect/presentation/screens/ai_conversation/widgets/typing_bubble.dart';
import 'package:learn_connect/presentation/screens/ai_conversation/widgets/voice_message_bubble.dart';

import '../view_models/ai_chat_screen_state.dart';
import '../view_models/ai_chat_view_model.dart';
import 'input_field.dart';


class AIChatScreen extends ConsumerStatefulWidget {
  const AIChatScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<AIChatScreen> {
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
    final viewModel = ref.read(aiChatProvider.notifier);

    final voiceMessageList = ref.watch(
      aiChatProvider.select((s) => s.voiceMessageList),
    );
    final isWaitingAIReply = ref.watch(
      aiChatProvider.select((s) => s.isWaitingAIReply),
    );
    final permissionToAISpeak = ref.watch(
      aiChatProvider.select((s) => s.permissionToAISpeak),
    );

    // Gộp danh sách message và typing indicator
    final List<VoiceMessage?> items = [...voiceMessageList];
    if (isWaitingAIReply) items.add(null);

    ref.listen<AIChatScreenState>(aiChatProvider, (previous, next) {
      if (previous?.voiceMessageList != next.voiceMessageList) {
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
        title: const Text(
          'AI Conversation',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: viewModel.togglePermissionToAISpeak,
            icon: Icon(
              permissionToAISpeak
                  ? Icons.volume_up_sharp
                  : Icons.volume_off_sharp,
            ),
            color: const Color(0xFF256DFF),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () {
              showChatSettingsBottomSheet(context, ref);
            },
            icon: const Icon(Icons.more_horiz_outlined),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                if (item == null) {
                  return const TypingBubble();
                }
                return MessageBubble(
                  isSentByMe: item.isMe,
                  message: item.message,
                  aiSpeak: viewModel.aiSpeak,
                  userAudioPlay: viewModel.aiSpeak,
                );
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
      ref.read(aiChatProvider.notifier).sendMessage(msg);
      _controller.clear();
    }
  }

  void showChatSettingsBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Consumer(
          builder: (context, ref, _) {
            final autoSendEnabled = ref.watch(
              aiChatProvider.select((s) => s.autoSendVoiceMessage),
            );
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Cài đặt cuộc trò chuyện',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text("Tự động gửi sau khi nói"),
                    value: autoSendEnabled,
                    onChanged: (_) {
                      ref.read(aiChatProvider.notifier).toggleAutoSendVoiceMessage();
                    },
                    activeColor: Colors.blue,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
