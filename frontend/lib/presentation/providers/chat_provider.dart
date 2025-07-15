import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/constants/api_constants.dart';
import '../../data/datasources/chat_remote_datasource.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/document.dart';
import '../../domain/repositories/chat_repository.dart';

part 'chat_provider.freezed.dart';

// Dio provider
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl, // This was missing
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: const Duration(minutes: 10), // Increased timeout
    ),
  );

  // Add interceptors for logging in debug mode
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  return dio;
});

// Data source provider
final chatDataSourceProvider = Provider<ChatRemoteDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return ChatRemoteDataSource(dio: dio);
});

// Repository provider
final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final dataSource = ref.read(chatDataSourceProvider);
  return ChatRepositoryImpl(remoteDataSource: dataSource);
});

// Chat state
@freezed
abstract class ChatState with _$ChatState {
  const factory ChatState({
    @Default([]) List<Document> documents,
    @Default([]) List<ChatMessage> messages,
    @Default(false) bool isLoading,
    String? error,
    String? conversationId,
  }) = _ChatState;
}

// Chat notifier
class ChatNotifier extends StateNotifier<ChatState> {
  final ChatRepository repository;

  ChatNotifier({required this.repository}) : super(const ChatState()) {
    getDocuments();
  }

  Future<void> getDocuments() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final documents = await repository.getDocuments();
      state = state.copyWith(documents: documents, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> ingestDocument() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await repository.ingestDocument();
      await getDocuments(); // Refresh the list after ingestion
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void setConversationId(String documentId) {
    state = state.copyWith(
      conversationId: documentId,
      messages: [], // Clear messages from previous chat
    );
  }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;
    if (state.conversationId == null) {
      state = state.copyWith(error: "Please select a document to chat with.");
      return;
    }

    // Add user message
    final userMessage = ChatMessage(
      content: message,
      isUser: true,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
      error: null,
    );

    try {
      // Send to API
      final response = await repository.sendMessage(
        message,
        state.conversationId,
      );

      // Add AI response
      state = state.copyWith(
        messages: [...state.messages, response],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Chat provider
final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  final repository = ref.read(chatRepositoryProvider);
  return ChatNotifier(repository: repository);
});
