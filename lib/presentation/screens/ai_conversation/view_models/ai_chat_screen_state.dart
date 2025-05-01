class VoiceMessage {
  final String message;
  final bool isMe;

  const VoiceMessage({this.message = '', this.isMe = false});
}

class AIChatScreenState {
  final List<VoiceMessage> voiceMessageList;
  final bool isListening;
  final bool isWaitingAIReply;
  final bool permissionToAISpeak;
  final String audioToTextData;
  final bool autoSendVoiceMessage;

  const AIChatScreenState({
    required this.voiceMessageList,
    this.isListening = false,
    this.isWaitingAIReply = false,
    this.audioToTextData = '',
    this.permissionToAISpeak = true,
    this.autoSendVoiceMessage = false
  });

  AIChatScreenState copyWith({
    List<VoiceMessage>? voiceMessageList,
    bool? isListening,
    bool? isWaitingAIReply,
    String? audioToTextData,
    bool? permissionToAISpeak,
    bool? autoSendVoiceMessage
  }) {
    return AIChatScreenState(
      voiceMessageList: voiceMessageList ?? this.voiceMessageList,
      isListening: isListening ?? this.isListening,
      isWaitingAIReply: isWaitingAIReply ?? this.isWaitingAIReply,
      audioToTextData: audioToTextData ?? this.audioToTextData,
      permissionToAISpeak: permissionToAISpeak ?? this.permissionToAISpeak,
      autoSendVoiceMessage: autoSendVoiceMessage ?? this.autoSendVoiceMessage
    );
  }
}
