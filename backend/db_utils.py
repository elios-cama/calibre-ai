import psycopg2
import uuid
from typing import List, Dict, Any, Optional
import logging
from uuid import UUID

# Configure logging
logger = logging.getLogger(__name__)

def get_document_list_from_db() -> List[Dict[str, Any]]:
    """
    Retrieves a list of all documents from the database with their chunk counts.
    Works with the actual pgvector table structure.
    """
    db_url = "postgresql://myuser:mypassword@localhost:5432/my_rag_db"
    conn = None
    try:
        conn = psycopg2.connect(db_url)
        cur = conn.cursor()
        
        # Query that works with the actual table structure
        # Get unique document names and their creation info
        query = """
            SELECT 
                name,
                COUNT(*) as chunk_count,
                MIN(created_at) as first_created,
                MAX(updated_at) as last_updated
            FROM 
                ai.pdf_documents
            WHERE 
                name IS NOT NULL
            GROUP BY 
                name
            ORDER BY 
                MAX(updated_at) DESC;
        """
        
        cur.execute(query)
        
        documents = []
        for row in cur.fetchall():
            # Generate a UUID for the document based on its name
            import uuid
            doc_id = str(uuid.uuid5(uuid.NAMESPACE_URL, row[0]))
            
            documents.append({
                "id": doc_id,
                "filename": row[0],
                "chunk_count": row[1],
                "ingested_at": row[3].isoformat() if row[3] else (row[2].isoformat() if row[2] else None),
            })
            
        return documents
    except Exception as e:
        logger.error(f"❌ Error fetching document list: {e}")
        raise
    finally:
        if conn:
            conn.close()

def get_filename_from_uuid(document_id: str) -> Optional[str]:
    """
    Get the filename from a document UUID by checking both library system and database.
    Returns the filename that matches the given UUID.
    """
    # First, try to find in the new library system
    try:
        from library_manager import LibraryManager
        library_manager = LibraryManager()
        
        # Check if this is a library document
        metadata = library_manager.get_document_metadata(document_id)
        if metadata:
            # For library documents, use the original filename as the agent key
            return metadata['original_filename']
            
    except Exception as e:
        logger.warning(f"⚠️ Could not check library system for UUID {document_id}: {e}")
    
    # If not found in library, try the old database system with generated UUIDs
    conn_str = "postgresql://myuser:mypassword@localhost:5432/my_rag_db"
    conn = psycopg2.connect(conn_str)
    
    try:
        with conn.cursor() as cur:
            cur.execute("""
                SELECT DISTINCT name 
                FROM ai.pdf_documents 
                WHERE name IS NOT NULL
            """)
            results = cur.fetchall()
            
            for row in results:
                filename = row[0]
                if str(uuid.uuid5(uuid.NAMESPACE_URL, filename)) == document_id:
                    return filename
            
            raise ValueError(f"No document found for UUID: {document_id}")
    finally:
        conn.close() 