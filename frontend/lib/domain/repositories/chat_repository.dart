import '../entities/chat_message.dart';
import '../entities/document.dart';

abstract class ChatRepository {
  Future<List<Document>> getDocuments();
  Future<void> ingestDocument();
  Future<ChatMessage> sendMessage(String message, [String? conversationId]);
}
