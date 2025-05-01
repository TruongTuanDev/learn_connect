import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/ai_chat_view_model.dart';

class InputField extends ConsumerWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const InputField({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioText = ref.watch(aiChatProvider.select((s) => s.audioToTextData));
    final bool isListening = ref.watch(aiChatProvider.select((s) => s.isListening));

    controller.text = audioText;
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              minLines: 1,
              maxLines: 6,
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Soạn tin nhắn',
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (_) => onSend(),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: ref.read(aiChatProvider.notifier).handleSpeaking,
            child: CircleAvatar(
              backgroundColor: const Color(0xFF256DFF),
              child: Icon(
                isListening ? Icons.stop : Icons.mic,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onSend,
            child: const CircleAvatar(
              backgroundColor: Color(0xFF256DFF),
              child: Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
