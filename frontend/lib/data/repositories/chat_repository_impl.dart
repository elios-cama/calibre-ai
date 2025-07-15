import '../../domain/entities/chat_message.dart';
import '../../domain/entities/document.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_datasource.dart';
import '../models/chat_request_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Document>> getDocuments() {
    return remoteDataSource.getDocuments();
  }

  @override
  Future<void> ingestDocument() {
    return remoteDataSource.ingestDocument();
  }

  @override
  Future<ChatMessage> sendMessage(
    String message, [
    String? conversationId,
  ]) async {
    try {
      final request = ChatRequestModel(
        query: message,
        conversationId: conversationId,
      );

      final response = await remoteDataSource.sendMessage(request);

      return ChatMessage(
        content: response.response,
        isUser: false,
        timestamp: DateTime.now(),
        conversationId: response.conversationId,
      );
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }
}
