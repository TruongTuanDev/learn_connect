import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:learn_connect/presentation/screens/ai_conversation/data/gemini.dart';
import 'package:learn_connect/presentation/screens/ai_conversation/view_models/ai_chat_screen_state.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AIChatViewModel extends StateNotifier<AIChatScreenState> {
  final GeminiService _geminiService = GeminiService();
  final speech = SpeechToText();
  final tts = FlutterTts();

  AIChatViewModel() : super(const AIChatScreenState(voiceMessageList: []));

  /// Xây dựng chuỗi context cho Gemini API.
  ///  - Nếu chưa có tin nhắn nào, thêm system prompt để đặt mục tiêu cuộc trò chuyện.
  ///  - Sau đó, nối tất cả tin nhắn đã có, đánh dấu bằng "User:" và "Assistant:".
  ///  - Cuối cùng, thêm "Assistant:" ở cuối để dấu hiệu yêu cầu phản hồi.
  String get conversationPrompt {
    String prompt =
        "You are a friendly and supportive AI conversation partner who helps users"
        " practice English speaking.Always respond only in natural, fluent English, "
        "as if you are a native speaker having a casual conversation.Your goal is to "
        "keep the conversation engaging, correct subtle mistakes gently if needed, and "
        "encourage the user to speak more.Keep your replies clear and concise, "
        "and ask follow-up questions to continue the dialogue.";

    // Nối toàn bộ tin nhắn đã có
    for (VoiceMessage chat in state.voiceMessageList) {
      if (chat.isMe) {
        prompt += "User: ${chat.message}\n";
      } else {
        prompt += "Assistant: ${chat.message}\n";
      }
    }

    // Thêm dấu hiệu yêu cầu phản hồi từ AI
    prompt += "Assistant:";

    return prompt;
  }

  /// Hàm xử lý gửi tin nhắn và nhận phản hồi từ Gemini API với ngữ cảnh cuộc trò chuyện.
  Future<void> sendMessage(String userMsg) async {
    if (userMsg.trim().isEmpty) return;

    // Thêm tin nhắn của người dùng vào danh sách chat
    final updatedChats = [
      ...state.voiceMessageList,
      VoiceMessage(message: userMsg.trim(), isMe: true),
    ];
    state = state.copyWith(
      voiceMessageList: updatedChats,
      isWaitingAIReply: true,
      audioToTextData: '',
    );

    // Tạo prompt sử dụng toàn bộ cuộc hội thoại cùng với system prompt ban đầu
    final prompt = conversationPrompt;

    try {
      // Gọi Gemini API với prompt có chứa toàn bộ ngữ cảnh
      String aiResponse = await _geminiService.sendMessage(prompt);
      // Thêm phản hồi từ AI vào danh sách
      state = state.copyWith(
        voiceMessageList: [
          ...state.voiceMessageList,
          VoiceMessage(message: aiResponse.trim(), isMe: false),
        ],
      );
      aiSpeak(aiResponse);
    } catch (e) {
      state = state.copyWith(
        voiceMessageList: [
          ...state.voiceMessageList,
          VoiceMessage(message: 'Sorry, an error occurred.', isMe: false),
        ],
      );
    } finally {
      state = state.copyWith(isWaitingAIReply: false);
    }
  }

  Future<void> handleSpeaking() async {
    _requestPermission();
    if (!state.isListening) {
      bool available = await speech.initialize(
        onStatus: (status) {
          print('Speech status: $status');
          if (status == 'notListening' && state.isListening) {
            // Speech tự kết thúc (timeout hoặc lỗi)
            state = state.copyWith(isListening: false);

          }
        },
        onError: (error) {
          print('Speech error: $error');
          state = state.copyWith(isListening: false);
        },
      );
      if (available) {
        state = state.copyWith(isListening: true, audioToTextData: '');
        speech.listen(
          onResult: (result) {
            state = state.copyWith(audioToTextData: result.recognizedWords);
          },
          localeId: 'en_US',
          pauseFor: Duration(seconds: 20),
          listenFor: Duration(minutes: 2),
          listenOptions: SpeechListenOptions(
            partialResults: true,
            listenMode: ListenMode.dictation, // dùng ở đây, không bị deprecated
          ),
        );
      }
    } else { //dừng nghe thi lam
      state = state.copyWith(isListening: false);
      await speech.stop();
      if (state.audioToTextData.isNotEmpty && state.autoSendVoiceMessage) {
        sendMessage(state.audioToTextData);
      }
    }
  }

  void togglePermissionToAISpeak() {
    state = state.copyWith(permissionToAISpeak: !state.permissionToAISpeak);
  }

  //Yeu cầu quyền micro
  void _requestPermission() async {
    var status = await Permission.microphone.request();
  }

  void aiSpeak(String speech) {
    if (state.permissionToAISpeak) {
      tts.speak(speech.trim());
    }
  }

  void toggleAutoSendVoiceMessage() {
    state = state.copyWith(autoSendVoiceMessage: !state.autoSendVoiceMessage);
  }

  void clearChat() {
    state = const AIChatScreenState(voiceMessageList: []);
  }
}

final aiChatProvider =
    StateNotifierProvider<AIChatViewModel, AIChatScreenState>(
      (ref) => AIChatViewModel(),
    );
