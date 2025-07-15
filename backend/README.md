# TCM RAG System

A FastAPI-based AI assistant that uses Retrieval-Augmented Generation (RAG) to answer questions about PDF documents. Specifically designed for Traditional Chinese Medicine (TCM) texts, but works with any PDF documents.

Built with Google Gemini 2.5 Flash, Supabase (PostgreSQL + pgvector), and custom PDF processing.

## ✨ Features

- 📄 **Smart PDF Processing**: Custom reader that filters empty content and handles large documents
- 🔍 **Semantic Search**: Vector embeddings for intelligent document retrieval
- 🤖 **AI Chat**: Google Gemini 2.5 Flash for contextual responses
- 💾 **Production Database**: Supabase with pgvector for vector storage
- 🚀 **FastAPI**: Modern API with automatic documentation
- ⚡ **Smart Caching**: Avoids re-processing documents on restart
- 🐳 **Docker Ready**: Containerized for easy deployment

## 🚀 Complete Setup Guide

### Step 1: Clone Repository

```bash
git clone git@github.com:elios-cama/tcm_rag.git
cd tcm_rag
```

### Step 2: Python Environment

```bash
# Create virtual environment
python -m venv .venv
source .venv/bin/activate  # Mac/Linux
# .venv\Scripts\activate   # Windows

# Install dependencies
pip install -r requirements.txt
```

### Step 3: Get Google AI API Key

1. Go to [Google AI Studio](https://aistudio.google.com/app/apikey)
2. Create new API key
3. Copy the key (starts with `AIza...`)

### Step 4: Setup Supabase Database

1. **Create Supabase Project**:
   - Go to [supabase.com](https://supabase.com)
   - Click "Start your project" → "New project"
   - Choose organization, name your project
   - Set a strong database password
   - Wait for setup to complete (~2 minutes)

2. **Get Database Connection String**:
   - Go to Project Settings → Database
   - Find "Connection string" section
   - Copy the connection string (looks like: `postgresql://postgres.[PROJECT_REF]:[PASSWORD]@aws-0-[REGION].pooler.supabase.com:6543/postgres`)

3. **Enable pgvector Extension**:
   - Go to SQL Editor in your Supabase dashboard
   - Run this command:
   ```sql
   CREATE EXTENSION IF NOT EXISTS vector;
   ```

### Step 5: Configure Environment

Create a `.env` file in the project root:

```bash
# Google AI API Key (required)
GOOGLE_API_KEY=AIza_your_actual_api_key_here

# Supabase Database URL (required)
DATABASE_URL=postgresql://postgres.your_project_ref:your_password@aws-0-region.pooler.supabase.com:6543/postgres

# Application Settings
PORT=8000
DEBUG=True
FORCE_RELOAD=false
```

### Step 6: Add Your PDF Documents

```bash
# Add your PDF files to the data directory
cp your-document.pdf data/pdf_files/
```

**Example**: The system was tested with "The Web That Has No Weaver - Ted Kaptchuk.pdf" (13.4MB TCM book)

### Step 7: Run the Application

```bash
python main.py
```

You should see:
```
🚀 Starting PDF RAG System...
🔧 Initializing PDF knowledge base...
📚 Found 1 PDF files
🗄️ Connecting to database...
📖 Loading PDF documents...
✅ Successfully loaded 1 PDF documents
✅ Knowledge base initialized successfully
INFO: Uvicorn running on http://0.0.0.0:8000
```

## 📡 API Usage

### Interactive Documentation
Visit: `http://localhost:8000/docs`

### Chat with cURL

**Basic Query:**
```bash
curl -X POST "http://localhost:8000/api/chat" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "What is traditional Chinese medicine?",
    "agent_type": "pdf_assistant"
  }'
```

**Example Response:**
```json
{
  "response": "Traditional Chinese Medicine (TCM) is a comprehensive medical system with a history of over 2,000 years. It is based on ancient texts, most notably the Huang-di Nei-jing (Inner Classic of the Yellow Emperor)...",
  "conversation_id": "uuid-string",
  "sources_used": 3
}
```

**Follow-up Questions (maintaining conversation):**
```bash
curl -X POST "http://localhost:8000/api/chat" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "What are the main therapeutic methods?",
    "agent_type": "pdf_assistant",
    "conversation_id": "uuid-from-previous-response"
  }'
```

### Health Check
```bash
curl http://localhost:8000/health
```

## 🏗️ Project Structure

```
tcm_rag/
├── agents/                   # AI agent logic
│   ├── __init__.py
│   └── pdf_agent.py         # PDF processing agent
├── data/
│   └── pdf_files/           # Place your PDFs here
│       └── README.md        # Instructions
├── models/                   # Data models
│   ├── __init__.py
│   └── chat_models.py       # Request/response schemas
├── routers/                  # API endpoints
│   ├── __init__.py
│   └── chat_router.py       # Chat API routes
├── knowledge_base.py         # Core RAG logic
├── pdf_reader_custom.py      # Custom PDF content filter
├── main.py                   # FastAPI application
├── example_usage.py          # CLI example
├── requirements.txt          # Dependencies
├── Dockerfile               # Docker configuration
├── railway.json             # Railway deployment
└── .gitignore              # Git ignore rules
```

## 🔧 How It Works

### 1. PDF Processing Pipeline
```
PDF → Extract Text → Filter Content → Create Chunks → Generate Embeddings → Store in DB
```

- **Custom PDF Reader**: Filters out empty pages, control characters
- **Content Validation**: Ensures chunks have meaningful content (30% letters minimum)
- **Smart Chunking**: 1000 characters with 100-character overlap
- **Embeddings**: Google Gemini text-embedding-004 model

### 2. Query Processing
```
User Question → Vector Search → Retrieve Context → Generate AI Response
```

- **Semantic Search**: Finds most relevant document chunks
- **Context Assembly**: Combines relevant chunks for comprehensive answers
- **AI Generation**: Google Gemini 2.5 Flash creates human-like responses

### 3. Production Optimizations
- ✅ **Smart Caching**: Only processes documents once, then uses cached embeddings
- ✅ **Error Handling**: Graceful handling of PDF processing issues
- ✅ **Rate Limiting**: 10 requests per minute protection
- ✅ **Conversation Memory**: Maintains context across chat sessions

## 🔄 Adding New Documents

When you add new PDFs:

1. **Add PDF to directory:**
```bash
cp new-book.pdf data/pdf_files/
```

2. **Force reload to process new documents:**
```bash
# Edit .env file
FORCE_RELOAD=true
```

3. **Restart application:**
```bash
python main.py
```

4. **Reset force reload:**
```bash
# Edit .env file
FORCE_RELOAD=false
```

## 🐳 Docker Deployment

```bash
# Build image
docker build -t tcm-rag .

# Run container
docker run -p 8000:8000 \
  -e GOOGLE_API_KEY=your_api_key \
  -e DATABASE_URL=your_supabase_url \
  -v $(pwd)/data:/app/data \
  tcm-rag
```

## ☁️ Railway Deployment

1. **Connect Repository**: Link GitHub repo to Railway
2. **Add Environment Variables**:
   - `GOOGLE_API_KEY`: Your Google AI API key
   - `DATABASE_URL`: Your Supabase connection string
3. **Deploy**: Push to main branch

Railway will automatically detect the `railway.json` configuration.

## 🛠️ Configuration Options

### Environment Variables

| Variable | Required | Description | Example |
|----------|----------|-------------|---------|
| `GOOGLE_API_KEY` | ✅ | Google AI API key | `AIza...` |
| `DATABASE_URL` | ✅ | Supabase connection string | `postgresql://postgres...` |
| `PORT` | ❌ | Server port | `8000` |
| `DEBUG` | ❌ | Enable debug logging | `True` |
| `FORCE_RELOAD` | ❌ | Re-process documents | `false` |

### Rate Limiting
- Default: 10 requests per minute per IP
- Configurable in `routers/chat_router.py`

## 🔍 Troubleshooting

### Common Issues

**1. "No database URL found"**
```bash
# Check your .env file has:
DATABASE_URL=postgresql://postgres...
```

**2. "extension 'vector' is not available"**
```sql
-- Run in Supabase SQL Editor:
CREATE EXTENSION IF NOT EXISTS vector;
```

**3. "Invalid input: 'content' argument must not be empty"**
- This means some PDF pages are empty/unreadable
- The system automatically filters these out
- If you see "✅ Processed PDF: filename - Valid: X, Skipped: Y", it's working correctly

**4. PDF not processing**
- Ensure PDF is text-based (not scanned image)
- Check file permissions
- Verify PDF is in `data/pdf_files/` directory

### Debug Mode

Enable detailed logging:
```bash
# In .env file
DEBUG=True
```

### Performance Monitoring

The system shows detailed metrics in debug mode:
- Processing time per query
- Token usage
- Number of sources used
- Database operations

## 📊 Example Performance

**Processing "The Web That Has No Weaver" (13.4MB TCM book):**
- ✅ 545 valid chunks processed
- ✅ 4 empty chunks skipped
- ✅ ~3.6 seconds per query response
- ✅ ~6,000 tokens per comprehensive answer

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with your own PDFs
5. Submit a pull request

## 📄 License

This project is open source. See LICENSE file for details.

## 🎯 Use Cases

- **Academic Research**: Query medical texts and research papers
- **Educational Tool**: Learn about Traditional Chinese Medicine concepts
- **Clinical Reference**: Quick lookup of treatment protocols and diagnostic methods
- **General Knowledge**: Ask questions about any PDF documents you upload

## 🎯 PgVector Optimization for Long Books

### Current Optimized Configuration

The system is now optimized for retrieving information from long books with the following configuration:

#### **Search Configuration**
- **Search Type**: `SearchType.hybrid` 
  - Combines vector similarity + full-text search
  - Better for finding both semantically similar and keyword-matched content
  - Ideal for comprehensive book searches

#### **Distance Metric**
- **Distance**: `Distance.cosine`
  - Best for text embeddings (normalized vectors)
  - More robust than L2 distance for high-dimensional text data
  - Standard choice for semantic similarity

#### **Vector Index Configuration**
- **Index Type**: `HNSW` (Hierarchical Navigable Small World)
  - **m=16**: Higher connectivity for better recall (vs default 16)
  - **ef_construction=200**: Better index quality during build (vs default 64)
  - **ef_search=100**: Better search quality at query time (vs default 40)

#### **Chunking Strategy**
- **Chunk Size**: 800 characters (optimized from 1000)
  - Better semantic coherence
  - Balances context preservation with search precision
- **Chunk Overlap**: 200 characters (increased from 100)
  - Preserves context across chunk boundaries
  - Reduces information loss at chunk splits

#### **Search Parameters**
- **Number of Results**: 15 (increased from 10)
  - More comprehensive coverage for complex questions
  - Better for long books with distributed information
- **Vector Score Weight**: 0.7
  - Favors semantic similarity over keyword matching
  - Optimal for conceptual questions about book content

#### **Full-Text Search Enhancements**
- **Prefix Matching**: Enabled
  - Better partial word matching
  - Improved search for technical terms and names
- **Content Language**: English
  - Optimized text search processing

### Performance Characteristics

| Configuration | Best For | Trade-offs |
|---------------|----------|------------|
| **Hybrid Search** | Complex queries needing both semantic and keyword matching | Slightly slower than pure vector search |
| **HNSW Index** | Fast approximate searches with good recall | Higher memory usage than IVFFlat |
| **Cosine Distance** | Text embeddings, normalized vectors | Standard choice, no significant trade-offs |
| **Higher ef_search** | Better search quality | Slightly slower query time |
| **Larger Overlap** | Context preservation | More storage usage |

### When to Adjust Configuration

#### For Very Large Books (>1000 pages):
```python
# Consider these adjustments in knowledge_base.py
chunk_size=600,  # Smaller chunks for faster processing
num_documents=20,  # More results for comprehensive coverage
```

#### For Technical/Medical Books:
```python
# Enable more precise matching
vector_score_weight=0.8,  # Higher weight on semantic similarity
ef_search=150,  # Even better search quality
```

#### For Faster Performance (Trade-off Accuracy):
```python
# Faster but less accurate configuration
search_type=SearchType.vector,  # Pure vector search
ef_search=50,  # Lower search quality but faster
num_documents=10,  # Fewer results
```

### Monitoring and Optimization

To monitor performance:
1. Check query response times
2. Evaluate answer quality and completeness
3. Monitor database storage usage
4. Test with representative queries

The current configuration prioritizes answer quality and comprehensiveness over raw speed, which is optimal for TCM knowledge retrieval from long texts.

---

**Repository**: https://github.com/elios-cama/tcm_rag.git

For issues and questions, please open a GitHub issue.

## 🏗️ TCM SaaS Architecture (Supabase + Flutter)

### Database Schema Design

#### **Core Tables:**

```sql
-- Users table (Supabase Auth handles this)
CREATE TABLE profiles (
    id UUID REFERENCES auth.users ON DELETE CASCADE,
    email TEXT,
    full_name TEXT,
    subscription_tier TEXT DEFAULT 'free',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    PRIMARY KEY (id)
);

-- Chat Sessions
CREATE TABLE chat_sessions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    is_archived BOOLEAN DEFAULT FALSE
);

-- Chat Messages
CREATE TABLE chat_messages (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    session_id UUID REFERENCES chat_sessions(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    role TEXT NOT NULL CHECK (role IN ('user', 'assistant')),
    sources_used INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    metadata JSONB DEFAULT '{}'::jsonb
);

-- Knowledge Sources (track which PDFs were used)
CREATE TABLE knowledge_sources (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name TEXT NOT NULL,
    file_path TEXT,
    document_count INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    is_active BOOLEAN DEFAULT TRUE
);

-- Usage Analytics
CREATE TABLE usage_analytics (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    session_id UUID REFERENCES chat_sessions(id) ON DELETE CASCADE,
    action_type TEXT NOT NULL, -- 'message_sent', 'session_created', etc.
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    metadata JSONB DEFAULT '{}'::jsonb
);
```

#### **Row Level Security (RLS) Policies:**

```sql
-- Chat Sessions - Users can only see their own
ALTER TABLE chat_sessions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view own sessions" ON chat_sessions
    FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own sessions" ON chat_sessions
    FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own sessions" ON chat_sessions
    FOR UPDATE USING (auth.uid() = user_id);

-- Chat Messages - Users can only see messages from their sessions
ALTER TABLE chat_messages ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view own messages" ON chat_messages
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM chat_sessions 
            WHERE chat_sessions.id = chat_messages.session_id 
            AND chat_sessions.user_id = auth.uid()
        )
    );
CREATE POLICY "Users can insert own messages" ON chat_messages
    FOR INSERT WITH CHECK (
        EXISTS (
            SELECT 1 FROM chat_sessions 
            WHERE chat_sessions.id = chat_messages.session_id 
            AND chat_sessions.user_id = auth.uid()
        )
    );
```

### **Backend API Architecture**

#### **FastAPI + Supabase Integration:**

```python
# models/database.py
from supabase import create_client, Client
import os

supabase: Client = create_client(
    os.getenv("SUPABASE_URL"),
    os.getenv("SUPABASE_ANON_KEY")
)

# models/chat_models.py
from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime
import uuid

class ChatSession(BaseModel):
    id: Optional[uuid.UUID] = None
    user_id: uuid.UUID
    title: str
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None
    is_archived: bool = False

class ChatMessage(BaseModel):
    id: Optional[uuid.UUID] = None
    session_id: uuid.UUID
    content: str
    role: str  # 'user' or 'assistant'
    sources_used: int = 0
    created_at: Optional[datetime] = None
    metadata: dict = {}

class ChatRequest(BaseModel):
    session_id: uuid.UUID
    message: str
    user_id: uuid.UUID

class ChatResponse(BaseModel):
    message: ChatMessage
    sources: List[str] = []
```

#### **Enhanced Chat Router:**

```python
# routers/chat_router.py
from fastapi import APIRouter, HTTPException, Depends
from fastapi.security import HTTPBearer
from models.chat_models import *
from models.database import supabase
from knowledge_base import search_knowledge_base
import uuid

router = APIRouter()
security = HTTPBearer()

def verify_token(token: str = Depends(security)):
    """Verify Supabase JWT token"""
    try:
        user = supabase.auth.get_user(token.credentials)
        return user
    except:
        raise HTTPException(status_code=401, detail="Invalid token")

@router.post("/sessions", response_model=ChatSession)
async def create_session(
    title: str,
    user: dict = Depends(verify_token)
):
    """Create a new chat session"""
    session_data = {
        "user_id": user.user.id,
        "title": title
    }
    
    result = supabase.table("chat_sessions").insert(session_data).execute()
    return ChatSession(**result.data[0])

@router.get("/sessions", response_model=List[ChatSession])
async def get_user_sessions(
    user: dict = Depends(verify_token)
):
    """Get all chat sessions for a user"""
    result = supabase.table("chat_sessions")\
        .select("*")\
        .eq("user_id", user.user.id)\
        .eq("is_archived", False)\
        .order("updated_at", desc=True)\
        .execute()
    
    return [ChatSession(**session) for session in result.data]

@router.get("/sessions/{session_id}/messages", response_model=List[ChatMessage])
async def get_session_messages(
    session_id: uuid.UUID,
    user: dict = Depends(verify_token)
):
    """Get all messages for a session"""
    result = supabase.table("chat_messages")\
        .select("*")\
        .eq("session_id", str(session_id))\
        .order("created_at", desc=False)\
        .execute()
    
    return [ChatMessage(**message) for message in result.data]

@router.post("/chat", response_model=ChatResponse)
async def send_message(
    request: ChatRequest,
    user: dict = Depends(verify_token)
):
    """Send a message and get AI response"""
    
    # Save user message
    user_message_data = {
        "session_id": str(request.session_id),
        "content": request.message,
        "role": "user"
    }
    user_msg_result = supabase.table("chat_messages").insert(user_message_data).execute()
    
    # Get AI response from knowledge base
    context_results = search_knowledge_base(request.message, num_results=8)
    
    # Generate AI response (integrate with your existing agent)
    from agents.pdf_agent import get_pdf_agent
    agent = get_pdf_agent()
    ai_response = agent.run(request.message)
    
    # Save AI message
    ai_message_data = {
        "session_id": str(request.session_id),
        "content": ai_response.content,
        "role": "assistant",
        "sources_used": len(context_results),
        "metadata": {"sources": context_results}
    }
    ai_msg_result = supabase.table("chat_messages").insert(ai_message_data).execute()
    
    # Update session timestamp
    supabase.table("chat_sessions")\
        .update({"updated_at": "now()"})\
        .eq("id", str(request.session_id))\
        .execute()
    
    return ChatResponse(
        message=ChatMessage(**ai_msg_result.data[0]),
        sources=context_results
    )

@router.delete("/sessions/{session_id}")
async def archive_session(
    session_id: uuid.UUID,
    user: dict = Depends(verify_token)
):
    """Archive a chat session"""
    supabase.table("chat_sessions")\
        .update({"is_archived": True})\
        .eq("id", str(session_id))\
        .execute()
    
    return {"message": "Session archived"}
```

### **Flutter Web App Architecture**

#### **State Management with Riverpod:**

```dart
// providers/chat_provider.dart
@freezed
class ChatState with _$ChatState {
  const factory ChatState({
    @Default([]) List<ChatSession> sessions,
    ChatSession? currentSession,
    @Default([]) List<ChatMessage> currentMessages,
    @Default(false) bool isLoading,
    String? error,
  }) = _ChatState;
}

class ChatNotifier extends StateNotifier<ChatState> {
  final ChatRepository repository;
  
  ChatNotifier(this.repository) : super(const ChatState());
  
  Future<void> loadSessions() async {
    state = state.copyWith(isLoading: true);
    try {
      final sessions = await repository.getUserSessions();
      state = state.copyWith(sessions: sessions, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
  
  Future<void> createSession(String title) async {
    try {
      final session = await repository.createSession(title);
      state = state.copyWith(
        sessions: [session, ...state.sessions],
        currentSession: session,
        currentMessages: [],
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
  
  Future<void> selectSession(ChatSession session) async {
    state = state.copyWith(currentSession: session, isLoading: true);
    try {
      final messages = await repository.getSessionMessages(session.id);
      state = state.copyWith(currentMessages: messages, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
  
  Future<void> sendMessage(String content) async {
    if (state.currentSession == null) return;
    
    final userMessage = ChatMessage(
      sessionId: state.currentSession!.id,
      content: content,
      role: 'user',
      createdAt: DateTime.now(),
    );
    
    state = state.copyWith(
      currentMessages: [...state.currentMessages, userMessage],
      isLoading: true,
    );
    
    try {
      final response = await repository.sendMessage(
        state.currentSession!.id,
        content,
      );
      
      state = state.copyWith(
        currentMessages: [...state.currentMessages, response.message],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  final repository = ref.read(chatRepositoryProvider);
  return ChatNotifier(repository);
});
```

#### **Main Chat UI:**

```dart
// pages/chat_page.dart
class ChatPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatProvider);
    final chatNotifier = ref.read(chatProvider.notifier);
    
    return Scaffold(
      body: Row(
        children: [
          // Sidebar with sessions
          Container(
            width: 300,
            child: ChatSidebar(),
          ),
          
          // Main chat area
          Expanded(
            child: chatState.currentSession == null
                ? WelcomeScreen()
                : ChatMessagesView(),
          ),
        ],
      ),
    );
  }
}

// widgets/chat_sidebar.dart
class ChatSidebar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatProvider);
    final chatNotifier = ref.read(chatProvider.notifier);
    
    return Container(
      decoration: BoxDecoration(
        color: AppColors.warmCream,
        border: Border(right: BorderSide(color: AppColors.primaryGold.withOpacity(0.3))),
      ),
      child: Column(
        children: [
          // New Chat Button
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () => _showNewChatDialog(context, chatNotifier),
              icon: Icon(Icons.add),
              label: Text('New Chat'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGold,
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ),
          
          // Sessions List
          Expanded(
            child: ListView.builder(
              itemCount: chatState.sessions.length,
              itemBuilder: (context, index) {
                final session = chatState.sessions[index];
                final isSelected = chatState.currentSession?.id == session.id;
                
                return ListTile(
                  title: Text(
                    session.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    _formatDate(session.updatedAt),
                    style: TextStyle(fontSize: 12),
                  ),
                  selected: isSelected,
                  selectedTileColor: AppColors.primaryGold.withOpacity(0.1),
                  onTap: () => chatNotifier.selectSession(session),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 'delete') {
                        chatNotifier.archiveSession(session.id);
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

### **Deployment Strategy:**

1. **Backend**: FastAPI on Cloud Run (using your GCP credits)
2. **Database**: Supabase (handles auth, real-time, storage)
3. **Frontend**: Flutter Web on Firebase Hosting
4. **Vector DB**: Your existing PostgreSQL + pgvector setup

This architecture gives you:
- ✅ Multi-session chat like ChatGPT
- ✅ Real-time sync across devices
- ✅ Secure user authentication
- ✅ Scalable message storage
- ✅ Source tracking for multi-PDF support
- ✅ Usage analytics for business insights

The system is designed to scale from MVP to enterprise-level usage! 