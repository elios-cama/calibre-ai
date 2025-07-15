import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';

@freezed
abstract class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String content,
    required bool isUser,
    required DateTime timestamp,
    String? conversationId,
  }) = _ChatMessage;
}
