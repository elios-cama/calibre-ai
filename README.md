# 📚 Calibre-AI

<div align="center">

![Calibre-AI Logo](https://img.shields.io/badge/📚-Calibre--AI-blue?style=for-the-badge&labelColor=2C3E50)

**A Local-First, AI-Powered Document Management System**

*Chat with your documents using local AI models - inspired by Calibre, powered by Ollama*

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg?style=flat-square)](https://choosealicense.com/licenses/mit/)
[![Python](https://img.shields.io/badge/Python-3.8+-blue.svg?style=flat-square&logo=python)](https://www.python.org/)
[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg?style=flat-square&logo=flutter)](https://flutter.dev/)
[![FastAPI](https://img.shields.io/badge/FastAPI-Latest-green.svg?style=flat-square&logo=fastapi)](https://fastapi.tiangolo.com/)

</div>

---

## 🎯 **What is Calibre-AI?**

Calibre-AI is a **privacy-first document management system** that combines the organizational power of Calibre with modern AI capabilities. It allows you to:

- 📖 **Ingest & Organize**: Import PDFs, EPUBs, and other documents with rich metadata extraction
- 🧠 **Chat with Documents**: Ask questions about your documents using local AI models
- 🔒 **Complete Privacy**: Everything runs locally - no data leaves your machine
- 🎨 **Beautiful Interface**: Modern Flutter UI inspired by contemporary design principles
- 📱 **Native Experience**: Built specifically for macOS with platform-native feel

## ✨ **Key Features**

### 📚 **Document Library Management**
- **Rich Metadata Extraction**: Automatically extracts titles, authors, page counts, creation dates
- **Thumbnail Generation**: Creates preview images from PDF first pages and eBook covers
- **Multiple Format Support**: PDF, EPUB, MOBI, AZW, AZW3
- **Organized Storage**: Calibre-style library structure with permanent file retention

### 🤖 **AI-Powered Chat Interface**
- **Local AI Models**: Powered by Ollama (Mistral + nomic-embed-text)
- **Document-Specific Conversations**: Chat with individual documents
- **Vector Search**: Semantic search through document content using pgvector
- **Context-Aware Responses**: AI understands document context for relevant answers

### 🎨 **Modern User Interface**
- **Responsive Grid Layout**: Beautiful document library with real thumbnails
- **Ollama-Inspired Design**: Clean, modern aesthetic with Inter font
- **Smart Fallbacks**: Graceful handling of missing thumbnails with book cover placeholders
- **Intuitive Navigation**: Seamless flow between library and chat interfaces

### 🔧 **Technical Excellence**
- **Local-First Architecture**: PostgreSQL + pgvector for embeddings
- **Docker Containerization**: Easy setup and deployment
- **RESTful API**: FastAPI backend with comprehensive endpoints
- **State Management**: Riverpod for predictable Flutter state handling

---

## 🛠 **Tech Stack**

<div align="center">

| **Frontend** | **Backend** | **Database** | **AI/ML** |
|:---:|:---:|:---:|:---:|
| ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white) | ![FastAPI](https://img.shields.io/badge/FastAPI-005571?style=for-the-badge&logo=fastapi) | ![PostgreSQL](https://img.shields.io/badge/postgresql-4169e1?style=for-the-badge&logo=postgresql&logoColor=white) | ![Ollama](https://img.shields.io/badge/Ollama-000000?style=for-the-badge) |
| Riverpod | Python 3.8+ | pgvector | Mistral 7B |
| Google Fonts | PyMuPDF | Docker | nomic-embed-text |

</div>

---

## 🚀 **Quick Start**

### **Prerequisites**

Before you begin, ensure you have the following installed:

- **macOS** (Primary target platform)
- **Docker Desktop** - [Download here](https://www.docker.com/products/docker-desktop)
- **Ollama** - [Download here](https://ollama.com/)
- **Flutter SDK** - [Installation guide](https://docs.flutter.dev/get-started/install)
- **Python 3.8+** with pip

### **1. Clone the Repository**

```bash
git clone git@github.com:elios-cama/calibre-ai.git
cd calibre-ai
```

### **2. Set Up Environment Variables**

Copy the example environment file and configure your settings:

```bash
cp .env.example .env
# Edit .env with your preferred database credentials
# Default values work for local development
```

**Important Environment Variables:**
- `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB` - Database credentials
- `OLLAMA_HOST` - Ollama server URL (default: http://localhost:11434)
- `CHAT_MODEL` - AI chat model (default: mistral:7b)
- `EMBEDDING_MODEL` - Text embedding model (default: nomic-embed-text)

### **3. Set Up the Database**

Start PostgreSQL with pgvector using Docker:

```bash
docker-compose up -d
```

This creates a persistent PostgreSQL database with vector extensions at `localhost:5432`.

### **4. Set Up Ollama & AI Models**

```bash
# Download and start the AI models
ollama pull mistral:7b        # Main chat model
ollama pull nomic-embed-text  # Embedding model
```

Ollama runs automatically as a background service at `http://localhost:11434`.

### **5. Set Up the Backend**

```bash
cd backend

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On macOS/Linux

# Install dependencies
pip install -r requirements.txt

# Start the FastAPI server
uvicorn main:app --reload
```

The backend API will be available at `http://localhost:8000`.

### **6. Set Up the Frontend**

```bash
cd frontend

# Get Flutter dependencies
flutter pub get

# Run the app on macOS
flutter run -d macos
```

---

## 📖 **How to Use**

### **Adding Documents**
1. **Launch the App**: Open Calibre-AI on your macOS system
2. **Import Documents**: Click the "+" button to select PDF or eBook files
3. **Automatic Processing**: The system extracts metadata, generates thumbnails, and processes content
4. **Browse Library**: View your documents in the beautiful grid layout

### **Chatting with Documents**
1. **Select a Document**: Click on any document in your library
2. **Start Conversation**: Type your questions in the chat interface
3. **AI Responses**: Get contextual answers based on the document content
4. **Continuous Chat**: Maintain conversation history for each document

### **Managing Your Library**
- **Rich Metadata**: View author names, page counts, file sizes, and creation dates
- **Thumbnail Previews**: See actual document covers and first pages
- **Smart Organization**: Files are permanently stored in organized library structure
- **Search & Filter**: Find documents quickly in your growing collection

---

## 📁 **Project Structure**

```
calibre-ai/
├── 🐍 backend/                 # FastAPI Python Backend
│   ├── main.py                 # API endpoints and server setup
│   ├── library_manager.py      # Document processing and storage
│   ├── agent.py                # AI chat logic and embeddings
│   ├── db_utils.py             # Database operations
│   ├── data/                   # Document storage
│   │   ├── library/            # Organized document library
│   │   │   ├── documents/      # Original document files
│   │   │   ├── metadata/       # Document metadata JSON
│   │   │   └── thumbnails/     # Generated preview images
│   │   └── temp/               # Temporary processing files
│   └── requirements.txt        # Python dependencies
│
├── 📱 frontend/                # Flutter macOS Application
│   ├── lib/
│   │   ├── core/              # App configuration and themes
│   │   ├── data/              # Data sources and repositories
│   │   ├── domain/            # Business logic and entities
│   │   └── presentation/      # UI pages and widgets
│   ├── assets/                # App assets and images
│   └── pubspec.yaml           # Flutter dependencies
│
├── 🐳 docker-compose.yml      # Database container setup
├── 📋 .gitignore              # Git ignore patterns
└── 📖 README.md               # This file
```

---

## 🎯 **What We've Accomplished**

### **Phase 1: Foundation ✅**
- [x] **Monorepo Structure**: Combined Flutter frontend and Python backend
- [x] **Local Database**: PostgreSQL with pgvector for embeddings
- [x] **AI Integration**: Ollama with Mistral and nomic-embed-text models
- [x] **Docker Setup**: Containerized database with persistent storage

### **Phase 2: Core Functionality ✅**
- [x] **Document Ingestion**: PDF processing with chunking and embedding
- [x] **Chat Interface**: AI-powered conversations with documents
- [x] **API Design**: RESTful endpoints for all operations
- [x] **Error Handling**: Robust error management and user feedback

### **Phase 3: Library System ✅**
- [x] **Metadata Extraction**: Rich document information parsing
- [x] **Thumbnail Generation**: PDF first page and eBook cover previews
- [x] **Permanent Storage**: Calibre-style organized library structure
- [x] **Multiple Formats**: Support for PDF, EPUB, MOBI, AZW files

### **Phase 4: UI Excellence ✅**
- [x] **Modern Design**: Ollama-inspired clean interface
- [x] **Responsive Layout**: Beautiful grid-based document library
- [x] **Real Thumbnails**: Actual document previews instead of placeholders
- [x] **State Management**: Riverpod for predictable app state

### **Phase 5: Polish & Integration ✅**
- [x] **Bug Fixes**: Resolved duplicate documents and UI overflow issues
- [x] **Chat Enhancement**: Fixed UUID mapping for new library system
- [x] **Performance**: Optimized document loading and thumbnail generation
- [x] **UX Improvements**: Smooth navigation and error handling

---

## 🔮 **Future Roadmap**

### **Planned Features**
- [ ] **Multi-Document Chat**: Ask questions across multiple documents
- [ ] **Advanced Search**: Full-text search with filters and tags
- [ ] **Document Annotations**: Highlight and note-taking features
- [ ] **Export Options**: Export conversations and document summaries
- [ ] **Cloud Sync**: Optional cloud backup while maintaining privacy
- [ ] **Plugin System**: Extensible architecture for custom processors

### **Platform Expansion**
- [ ] **iOS Support**: Native iPhone and iPad applications
- [ ] **Windows & Linux**: Cross-platform desktop applications
- [ ] **Web Interface**: Browser-based access option
- [ ] **Mobile Optimization**: Enhanced mobile experience

---

## 🤝 **Contributing**

We welcome contributions! Here's how you can help:

1. **Fork the Repository**
2. **Create a Feature Branch**: `git checkout -b feature/amazing-feature`
3. **Make Your Changes**: Follow our coding standards
4. **Test Thoroughly**: Ensure everything works correctly
5. **Submit a Pull Request**: Describe your changes clearly

### **Development Setup**
- Follow the **Quick Start** guide above
- Use the provided development scripts in `backend/`
- Run `flutter analyze` for frontend code quality
- Test both backend API and frontend integration

---

## 📄 **License**

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

## 🙏 **Acknowledgments**

- **Calibre**: Inspiration for document management approach
- **Ollama**: Local AI model serving platform
- **Flutter Team**: Amazing cross-platform UI framework
- **FastAPI**: Modern Python web framework
- **pgvector**: PostgreSQL vector similarity search

---

<div align="center">

**Built with ❤️ for document lovers and privacy advocates**

[Report Bug](https://github.com/elios-cama/calibre-ai/issues) • [Request Feature](https://github.com/elios-cama/calibre-ai/issues) • [Documentation](https://github.com/elios-cama/calibre-ai/wiki)

</div> 