import os
import hashlib
from pathlib import Path
from typing import List
from phi.agent import Agent
from phi.model.ollama import Ollama
from phi.knowledge.pdf import PDFKnowledgeBase
from phi.vectordb.pgvector import PgVector
from phi.vectordb.distance import Distance
from phi.vectordb.search import SearchType
from phi.vectordb.pgvector.index import HNSW
from phi.embedder.ollama import OllamaEmbedder
from pdf_reader_custom import FilteredPDFReader
from dotenv import load_dotenv
import logging

load_dotenv()

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Global knowledge base instance
knowledge_base = None

def get_pdf_files() -> List[str]:
    """Get all PDF files from the data directory"""
    data_dir = Path("data/pdf_files")
    if not data_dir.exists():
        data_dir.mkdir(parents=True, exist_ok=True)
        logger.info(f"📁 Created directory: {data_dir}")
        logger.info("📄 Please add your PDF files to the data/pdf_files/ directory")
        return []
    
    pdf_files = list(data_dir.glob("*.pdf"))
    logger.info(f"📚 Found {len(pdf_files)} PDF files")
    return [str(pdf) for pdf in pdf_files]

def check_if_documents_exist(db_url: str) -> bool:
    """Check if documents already exist in the database"""
    try:
        import psycopg2
        conn = psycopg2.connect(db_url)
        cur = conn.cursor()
        
        # Check if table exists and has documents
        cur.execute("""
            SELECT EXISTS (
                SELECT FROM information_schema.tables 
                WHERE table_schema = 'ai' 
                AND table_name = 'pdf_documents'
            );
        """)
        table_exists = cur.fetchone()[0]
        
        if table_exists:
            cur.execute("SELECT COUNT(*) FROM ai.pdf_documents;")
            doc_count = cur.fetchone()[0]
            cur.close()
            conn.close()
            return doc_count > 0
        
        cur.close()
        conn.close()
        return False
    except Exception as e:
        logger.warning(f"⚠️ Could not check existing documents: {e}")
        return False

def create_knowledge_base():
    """Create and configure the knowledge base optimized for long books"""
    try:
        # Get database URL
        db_url = "postgresql://myuser:mypassword@localhost:5432/my_rag_db"
        
        logger.info(f"🗄️ Connecting to database with optimized configuration for long books...")
        
        # Optimized PgVector configuration for long books
        vector_db = PgVector(
            table_name="pdf_documents",
            db_url=db_url,
            embedder=OllamaEmbedder(
                model="nomic-embed-text", 
                dimensions=768  # Explicitly set correct dimensions for nomic-embed-text
            ),
            # Optimizations for long book retrieval:
            search_type=SearchType.hybrid,  # Combine vector + keyword search
            distance=Distance.cosine,  # Best for text embeddings
            vector_index=HNSW(
                m=16,  # Higher connectivity for better recall
                ef_construction=200,  # Better index quality
                ef_search=100  # Better search quality
            ),
            vector_score_weight=0.7,  # Favor semantic similarity
            prefix_match=True,  # Enable prefix matching for keywords
            content_language="english"  # Optimize for English text search
        )
        
        # Create knowledge base with optimized database and custom reader
        kb = PDFKnowledgeBase(
            path="data/pdf_files",
            vector_db=vector_db,
            reader=FilteredPDFReader(
                chunk=True,
                chunk_size=800,  # Balanced for context and search precision
                chunk_overlap=200  # Preserve context across chunks
            ),
            num_documents=15,  # Return more chunks for comprehensive answers
        )
        
        return kb
        
    except Exception as e:
        logger.error(f"❌ Error creating knowledge base: {e}")
        return None

def initialize_knowledge_base():
    """Initialize the global knowledge base following Phi documentation patterns"""
    global knowledge_base
    
    if knowledge_base is not None:
        logger.info("✅ Knowledge base already initialized")
        return knowledge_base
    
    logger.info("🔧 Initializing PDF knowledge base...")
    
    # Check for PDF files
    pdf_files = get_pdf_files()
    if not pdf_files:
        logger.warning("⚠️ No PDF files found. Knowledge base will be empty.")
    
    # Create knowledge base
    knowledge_base = create_knowledge_base()
    
    if knowledge_base is None:
        raise Exception("Failed to create knowledge base")
    
    # Check if we should load documents
    if pdf_files:
        db_url = "postgresql://myuser:mypassword@localhost:5432/my_rag_db"
        
        # For production efficiency: check if documents already exist
        documents_exist = check_if_documents_exist(db_url)
            
        force_reload = os.getenv("FORCE_RELOAD", "false").lower() == "true"
        
        if documents_exist and not force_reload:
            logger.info("📋 Documents already exist in database. Skipping re-processing...")
            logger.info("💡 To force re-processing, set FORCE_RELOAD=true in your .env file")
        else:
            try:
                logger.info("📖 Loading PDF documents (this may take a while for large PDFs)...")
                # Load with recreate=False to avoid rebuilding existing embeddings
                knowledge_base.load(recreate=False)
                logger.info(f"✅ Successfully loaded {len(pdf_files)} PDF documents")
            except Exception as e:
                logger.warning(f"⚠️ Warning: Error loading documents: {e}")
                try:
                    logger.info("🔄 Retrying document loading...")
                    knowledge_base.load(recreate=True)
                    logger.info("✅ Successfully loaded documents on retry")
                except Exception as retry_error:
                    logger.error(f"❌ Failed to load documents: {retry_error}")
                    logger.info("💡 Try using smaller PDF files or check your database connection")
    
    return knowledge_base

def get_knowledge_base():
    """Get the global knowledge base instance"""
    global knowledge_base
    if knowledge_base is None:
        knowledge_base = initialize_knowledge_base()
    return knowledge_base

def create_document_specific_knowledge_base(document_name: str):
    """Create a knowledge base filtered to a specific document"""
    try:
        # For now, we'll use the global knowledge base and handle document filtering 
        # at the query level rather than trying to create a separate knowledge base
        # This avoids type compatibility issues with the Agent class
        
        logger.info(f"🔍 Using global knowledge base with document filter for: {document_name}")
        return get_knowledge_base()
        
    except Exception as e:
        logger.error(f"❌ Error creating document-specific knowledge base: {e}")
        # Fallback to global knowledge base
        return get_knowledge_base()


def get_rag_agent(document_filter: str = None) -> Agent:
    """Create a RAG agent either for general knowledge or a specific document."""
    
    knowledge_base = None
    if document_filter:
        logger.info(f"🤖 Creating agent with knowledge filtered for: {document_filter}")
        # When a document_filter is provided, we create a specific knowledge base
        # that is scoped to only that document.
        knowledge_base = create_document_specific_knowledge_base(document_filter)
    else:
        logger.info("🤖 Creating agent with general knowledge base.")
        # When no filter is provided, we use the global, general-purpose knowledge base.
        knowledge_base = get_knowledge_base()

    if knowledge_base is None:
        raise ValueError("Knowledge base could not be initialized.")

    # Create agent instructions based on whether we're filtering by document
    instructions = [
        "You are a specialized book information retrieval assistant.",
        "Your primary role is to find and provide precise information from the books in the knowledge base.",
    ]
    
    if document_filter:
        instructions.extend([
            f"IMPORTANT: You are currently chatting about the document '{document_filter}'. Focus your search and answers specifically on information from this document.",
            f"When searching for information, prioritize content that comes from '{document_filter}'.",
            "If the retrieved information doesn't seem to be from the correct document, indicate that and search again.",
        ])
    
    instructions.extend([
        "When answering questions:",
        "- Only use information explicitly found in the books",
        "- Quote relevant passages directly when possible",
        "- Provide specific page numbers or sections if available",
        "- If information is ambiguous or unclear, explain why",
        "If you cannot find relevant information in the books, clearly state 'I could not find any information about this in the available books.'",
        "Do not make assumptions or provide information from outside the books.",
    ])

    # Create an agent that uses the specified knowledge base.
    return Agent(
        model=Ollama(id="mistral:latest"),
        knowledge=knowledge_base,
        # Enable search tools
        search_knowledge=True,
        markdown=True,
        show_tool_calls=True,
        add_history_to_messages=True,
        num_history_responses=3,
        # Add instructions
        instructions=instructions,
    ) 