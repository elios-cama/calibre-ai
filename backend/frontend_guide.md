# TCM RAG Flutter Web App - Development Guide

## 🎯 Project Overview

Build a Flutter web application with a Traditional Chinese Medicine (TCM) inspired design to interact with the TCM RAG API. The app features a simple chat interface where users can ask questions about TCM documents and receive AI-generated responses.

**Tech Stack:**
- Flutter Web
- Riverpod (State Management)
- Freezed (Immutable Data Classes)
- Dio (HTTP Client)
- Clean Architecture (Domain/Data/Presentation)

## 🏛️ Architecture Structure

```
lib/
├── core/                     # Core utilities and constants
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_strings.dart
│   │   └── api_constants.dart
│   ├── theme/
│   │   └── app_theme.dart
│   └── utils/
│       └── error_handler.dart
├── data/                     # Data layer
│   ├── datasources/
│   │   └── chat_remote_datasource.dart
│   ├── models/
│   │   ├── chat_request_model.dart
│   │   └── chat_response_model.dart
│   └── repositories/
│       └── chat_repository_impl.dart
├── domain/                   # Domain layer
│   ├── entities/
│   │   ├── chat_message.dart
│   │   └── chat_response.dart
│   ├── repositories/
│   │   └── chat_repository.dart
│   └── usecases/
│       └── send_message_usecase.dart
├── presentation/             # Presentation layer
│   ├── pages/
│   │   └── chat_page.dart
│   ├── widgets/
│   │   ├── chat_bubble.dart
│   │   ├── chat_input.dart
│   │   ├── loading_indicator.dart
│   │   └── tcm_background.dart
│   └── providers/
│       └── chat_provider.dart
└── main.dart
```

## 🎨 Design Guidelines - TCM Inspired Theme

### Color Palette
```dart
// core/constants/app_colors.dart
class AppColors {
  // Primary TCM colors inspired by traditional elements
  static const Color primaryRed = Color(0xFFB91C1C);        // Fire element
  static const Color primaryGold = Color(0xFFD97706);       // Earth element
  static const Color deepGreen = Color(0xFF065F46);         // Wood element
  static const Color softBeige = Color(0xFFF5F5DC);         // Natural background
  static const Color darkBrown = Color(0xFF78350F);         // Wood/Earth
  
  // Secondary colors
  static const Color lightGold = Color(0xFFFED7AA);         // Soft accent
  static const Color paleGreen = Color(0xFFDCFCE7);         // Healing green
  static const Color warmCream = Color(0xFFFFFBEB);         // Background
  static const Color charcoal = Color(0xFF374151);          // Text
  
  // Functional colors
  static const Color error = Color(0xFFDC2626);
  static const Color success = Color(0xFF059669);
  static const Color warning = Color(0xFFD97706);
  static const Color info = Color(0xFF2563EB);
}
```

### Typography
```dart
// core/theme/app_theme.dart
class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      fontFamily: 'Noto Serif', // Elegant serif for TCM feel
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryRed,
        brightness: Brightness.light,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: AppColors.darkBrown,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: AppColors.darkBrown,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.charcoal,
          height: 1.6,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.charcoal,
          height: 1.5,
        ),
      ),
    );
  }
}
```

### Design Principles
1. **Natural Elements**: Use warm earth tones, organic shapes
2. **Balance & Harmony**: Symmetric layouts, proper spacing
3. **Subtle Patterns**: Traditional Chinese patterns as background elements
4. **Calming Interface**: Soft transitions, gentle animations
5. **Readable Typography**: Clear hierarchy, comfortable reading

## 📱 UI Components Specifications

### Chat Bubble Design
```dart
// presentation/widgets/chat_bubble.dart
class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  final DateTime timestamp;
  final int? sourcesUsed;

  // User messages: Warm gold background, right-aligned
  // AI responses: Soft green background, left-aligned
  // Add subtle shadow and rounded corners
  // Include TCM-inspired decorative elements
}
```

### Chat Input Design
```dart
// presentation/widgets/chat_input.dart
class ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isLoading;

  // Traditional paper-like background
  // Gold accent send button with TCM symbol
  // Elegant input field with subtle border
  // Loading state with spinning yin-yang symbol
}
```

### Background Design
```dart
// presentation/widgets/tcm_background.dart
class TCMBackground extends StatelessWidget {
  // Subtle traditional Chinese pattern overlay
  // Gradient from warm cream to soft beige
  // Optional: Faint bamboo or cloud patterns
  // Ensure patterns don't interfere with readability
}
```

## 🔧 Implementation Guide

### 1. Project Setup

```bash
# Create Flutter project
flutter create tcm_chat_web --platforms web
cd tcm_chat_web

# Add dependencies to pubspec.yaml
```

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.4.9
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
  dio: ^5.3.2
  go_router: ^12.1.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.7
  freezed: ^2.4.6
  json_serializable: ^6.7.1
```

### 2. Core Constants

```dart
// core/constants/api_constants.dart
class ApiConstants {
  static const String baseUrl = 'http://localhost:8000'; // Your API URL
  static const String chatEndpoint = '/api/chat';
  static const String healthEndpoint = '/health';
  
  // Request timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 60);
}
```

```dart
// core/constants/app_strings.dart
class AppStrings {
  static const String appTitle = 'TCM Wisdom Chat';
  static const String welcomeMessage = 'Ask me anything about Traditional Chinese Medicine';
  static const String inputHint = 'Type your question about TCM...';
  static const String sendButton = 'Send';
  static const String errorMessage = 'Something went wrong. Please try again.';
  static const String networkError = 'Please check your internet connection.';
  static const String emptyResponse = 'I couldn\'t find relevant information. Try rephrasing your question.';
}
```

### 3. Data Models (Freezed)

```dart
// data/models/chat_request_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_request_model.freezed.dart';
part 'chat_request_model.g.dart';

@freezed
class ChatRequestModel with _$ChatRequestModel {
  const factory ChatRequestModel({
    required String query,
    @Default('pdf_assistant') String agentType,
    String? conversationId,
  }) = _ChatRequestModel;

  factory ChatRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRequestModelFromJson(json);
}
```

```dart
// data/models/chat_response_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_response_model.freezed.dart';
part 'chat_response_model.g.dart';

@freezed
class ChatResponseModel with _$ChatResponseModel {
  const factory ChatResponseModel({
    required String response,
    required String conversationId,
    required int sourcesUsed,
  }) = _ChatResponseModel;

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseModelFromJson(json);
}
```

### 4. Domain Entities

```dart
// domain/entities/chat_message.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String content,
    required bool isUser,
    required DateTime timestamp,
    int? sourcesUsed,
    String? conversationId,
  }) = _ChatMessage;
}
```

### 5. Repository Pattern

```dart
// domain/repositories/chat_repository.dart
import '../entities/chat_message.dart';

abstract class ChatRepository {
  Future<ChatMessage> sendMessage(String message, [String? conversationId]);
}
```

```dart
// data/repositories/chat_repository_impl.dart
import 'package:dio/dio.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_datasource.dart';
import '../models/chat_request_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ChatMessage> sendMessage(String message, [String? conversationId]) async {
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
        sourcesUsed: response.sourcesUsed,
        conversationId: response.conversationId,
      );
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }
}
```

### 6. Data Source

```dart
// data/datasources/chat_remote_datasource.dart
import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../models/chat_request_model.dart';
import '../models/chat_response_model.dart';

class ChatRemoteDataSource {
  final Dio dio;

  ChatRemoteDataSource({required this.dio});

  Future<ChatResponseModel> sendMessage(ChatRequestModel request) async {
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.chatEndpoint}',
        data: request.toJson(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        return ChatResponseModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Server returned ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Connection timeout. Please try again.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('Network error. Please check your connection.');
      } else {
        throw Exception('Failed to send message: ${e.message}');
      }
    }
  }
}
```

### 7. Riverpod Providers

```dart
// presentation/providers/chat_provider.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/api_constants.dart';
import '../../data/datasources/chat_remote_datasource.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/chat_repository.dart';

// Dio provider
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    connectTimeout: ApiConstants.connectTimeout,
    receiveTimeout: ApiConstants.receiveTimeout,
  ));
  
  // Add interceptors for logging in debug mode
  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
  ));
  
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
class ChatState with _$ChatState {
  const factory ChatState({
    @Default([]) List<ChatMessage> messages,
    @Default(false) bool isLoading,
    String? error,
    String? conversationId,
  }) = _ChatState;
}

// Chat notifier
class ChatNotifier extends StateNotifier<ChatState> {
  final ChatRepository repository;

  ChatNotifier({required this.repository}) : super(const ChatState());

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

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
        conversationId: response.conversationId,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
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
```

### 8. Main Chat Page

```dart
// presentation/pages/chat_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../providers/chat_provider.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input.dart';
import '../widgets/tcm_background.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatProvider);
    final chatNotifier = ref.read(chatProvider.notifier);

    return Scaffold(
      body: Stack(
        children: [
          // Background
          const TCMBackground(),
          
          // Main content
          Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryRed.withOpacity(0.1),
                      AppColors.primaryGold.withOpacity(0.1),
                    ],
                  ),
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.primaryGold.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      AppStrings.appTitle,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppStrings.welcomeMessage,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.darkBrown.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Chat messages
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: chatState.messages.length,
                  itemBuilder: (context, index) {
                    final message = chatState.messages[index];
                    return ChatBubble(
                      message: message.content,
                      isUser: message.isUser,
                      timestamp: message.timestamp,
                      sourcesUsed: message.sourcesUsed,
                    );
                  },
                ),
              ),
              
              // Loading indicator
              if (chatState.isLoading)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: LoadingIndicator(),
                ),
              
              // Error message
              if (chatState.error != null)
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.error.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: AppColors.error),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          chatState.error!,
                          style: TextStyle(color: AppColors.error),
                        ),
                      ),
                      IconButton(
                        onPressed: chatNotifier.clearError,
                        icon: Icon(Icons.close, color: AppColors.error),
                      ),
                    ],
                  ),
                ),
              
              // Input area
              ChatInput(
                onSend: (message) => chatNotifier.sendMessage(message),
                isLoading: chatState.isLoading,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

## 🎯 Key Features Implementation

### 1. Real-time Chat Interface
- Instant message display
- Typing indicators with TCM-inspired animations
- Smooth scrolling to latest messages

### 2. Error Handling
- Network error recovery
- User-friendly error messages
- Retry mechanisms

### 3. Responsive Design
- Mobile-first approach
- Tablet and desktop optimizations
- Flexible layouts

### 4. Performance Optimization
- Efficient list rendering
- Image caching for TCM elements
- Minimal rebuilds with Riverpod

## 🚀 Development Workflow

### Phase 1: Setup & Core (Day 1-2)
1. Create Flutter project structure
2. Set up clean architecture folders
3. Implement core constants and theme
4. Create basic data models with Freezed

### Phase 2: Data Layer (Day 2-3)
1. Implement Dio HTTP client
2. Create remote data source
3. Build repository implementation
4. Add error handling

### Phase 3: UI Implementation (Day 3-5)
1. Design and implement chat bubbles
2. Create input component
3. Build main chat page
4. Add TCM-inspired backgrounds

### Phase 4: State Management (Day 4-5)
1. Set up Riverpod providers
2. Implement chat state management
3. Handle loading and error states
4. Test message flow

### Phase 5: Polish & Testing (Day 5-6)
1. Add animations and transitions
2. Optimize for web performance
3. Test on different screen sizes
4. Final UI polish

## 📋 Testing Checklist

- [ ] API connection works correctly
- [ ] Messages send and receive properly
- [ ] Error states display appropriately
- [ ] Loading states show during requests
- [ ] Responsive design works on all screen sizes
- [ ] TCM theme is consistent throughout
- [ ] Accessibility features are implemented
- [ ] Performance is optimized for web

## 🎨 Design Assets Needed

1. **TCM Pattern SVGs**: Subtle background patterns
2. **Icons**: Custom TCM-inspired icons for send button, loading states
3. **Fonts**: Noto Serif or similar elegant serif font
4. **Color Swatches**: Exact color codes for consistency

## 📚 Additional Resources

- [Flutter Web Documentation](https://docs.flutter.dev/platform-integration/web)
- [Riverpod Documentation](https://riverpod.dev/)
- [Freezed Package](https://pub.dev/packages/freezed)
- [Dio HTTP Client](https://pub.dev/packages/dio)
- [Traditional Chinese Design Principles](https://en.wikipedia.org/wiki/Chinese_art)

This guide provides a complete foundation for building a production-ready TCM chat interface that's both functional and beautifully designed with Traditional Chinese Medicine aesthetics. 