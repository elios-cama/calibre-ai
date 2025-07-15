# TCM Wisdom Chat 🌿

A beautiful Flutter web application for interacting with Traditional Chinese Medicine (TCM) knowledge through an AI-powered chat interface. Features a traditional Chinese design aesthetic with warm earth tones and elegant typography.

## Features

🎨 **TCM-Inspired Design**
- Traditional Chinese color palette (reds, golds, greens)
- Elegant typography and serene interface
- Animated yin-yang loading indicator
- Subtle traditional patterns

💬 **Interactive Chat**
- Real-time messaging with your TCM RAG API
- Conversation context management
- Source count display for AI responses
- Error handling and user feedback

🏗️ **Clean Architecture**
- Domain-driven design with clear separation of concerns
- Riverpod for state management
- Freezed for immutable data models
- Repository pattern for API integration

## Prerequisites

- Flutter SDK (3.8.0 or higher)
- Your FastAPI RAG backend running on `http://localhost:8000`

## Getting Started

1. **Install Dependencies**
   ```bash
   flutter pub get
   ```

2. **Generate Code (if needed)**
   ```bash
   flutter packages pub run build_runner build
   ```

3. **Run the App**
   ```bash
   flutter run -d web-server --web-port 3000
   ```

4. **Open in Browser**
   Navigate to `http://localhost:3000`

## API Integration

The app expects your FastAPI backend to have a POST endpoint at `/api/chat` that accepts:

```json
{
  "query": "Your TCM question here",
  "agentType": "pdf_assistant",
  "conversationId": "optional-conversation-id"
}
```

And returns:

```json
{
  "response": "AI-generated response about TCM",
  "conversationId": "unique-conversation-id",
  "sourcesUsed": 3
}
```

See `API_INTEGRATION.md` for detailed API requirements.

## Project Structure

```
lib/
├── core/                     # Core utilities and constants
│   ├── constants/            # App colors, strings, API config
│   └── theme/               # App theme configuration
├── data/                     # Data layer
│   ├── datasources/         # HTTP API communication
│   ├── models/              # JSON serializable models
│   └── repositories/        # Repository implementations
├── domain/                   # Domain layer
│   ├── entities/            # Business entities
│   └── repositories/        # Repository interfaces
├── presentation/             # Presentation layer
│   ├── pages/               # App screens
│   ├── widgets/             # Reusable UI components
│   └── providers/           # Riverpod state providers
└── main.dart                # App entry point
```

## Configuration

### Changing API URL
Update the base URL in `lib/core/constants/api_constants.dart`:

```dart
static const String baseUrl = 'http://your-api-url:port';
```

### Customizing Colors
Modify the color palette in `lib/core/constants/app_colors.dart`

## Building for Production

```bash
flutter build web
```

The built files will be in the `build/web` directory.

## Troubleshooting

1. **CORS Issues**: Make sure your FastAPI backend allows requests from your Flutter web app URL
2. **Build Issues**: Run `flutter clean && flutter pub get` and try again
3. **Code Generation**: If you modify Freezed models, run `flutter packages pub run build_runner build`

## Contributing

This app follows clean architecture principles and uses:
- **Riverpod** for state management
- **Freezed** for immutable data classes
- **Dio** for HTTP requests
- **Flutter Web** for the UI

When adding new features, maintain the existing architecture patterns and TCM design aesthetic.
