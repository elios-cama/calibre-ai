# TCM Chat App - API Integration Guide

## Overview
This Flutter web app is designed to connect to your FastAPI RAG system. Below are the API requirements and format expected by the frontend.

## API Endpoint Configuration

### Base URL
The app is currently configured to connect to:
```
http://localhost:8000
```

You can change this in `lib/core/constants/api_constants.dart`

### Required Endpoint

#### POST `/api/chat`

**Request Format:**
```json
{
  "query": "What are the five elements in TCM?",
  "agentType": "pdf_assistant",
  "conversationId": "optional-conversation-id"
}
```

**Response Format:**
```json
{
  "response": "The five elements in Traditional Chinese Medicine are Wood, Fire, Earth, Metal, and Water...",
  "conversationId": "unique-conversation-id",
  "sourcesUsed": 3
}
```

### Request Fields
- `query` (string, required): The user's question about TCM
- `agentType` (string, optional): Defaults to "pdf_assistant"
- `conversationId` (string, optional): For maintaining conversation context

### Response Fields
- `response` (string, required): The AI-generated answer
- `conversationId` (string, required): Unique identifier for the conversation
- `sourcesUsed` (int, required): Number of document sources used in the response

## CORS Configuration
Make sure your FastAPI backend allows requests from `http://localhost:3000` (or your Flutter web app's URL):

```python
from fastapi.middleware.cors import CORSMiddleware

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000"],  # Add your Flutter web URL
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

## Testing the Connection
1. Start your FastAPI backend on `http://localhost:8000`
2. Run the Flutter app: `flutter run -d web-server --web-port 3000`
3. Open `http://localhost:3000` in your browser
4. Test by sending a message about TCM

## Error Handling
The app handles the following error scenarios:
- Network connection errors
- Timeout errors (30s connect, 60s receive)
- Server errors (non-200 status codes)
- Malformed JSON responses

## Features Implemented
✅ TCM-inspired UI design with traditional Chinese color palette
✅ Real-time chat interface
✅ Loading states with animated yin-yang symbol
✅ Error handling and user feedback
✅ Responsive design for web
✅ Source count display for AI responses
✅ Conversation context management
✅ Clean architecture with Riverpod state management 