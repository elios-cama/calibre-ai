from fastapi import FastAPI, HTTPException, UploadFile, File
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel
import uvicorn
import os
import shutil
from agent import get_rag_agent
from db_utils import get_document_list_from_db, get_filename_from_uuid
from library_manager import LibraryManager
from psycopg2 import ProgrammingError

# In-memory storage for agents to maintain conversation history
# The key is the document_id
agents = {}

# Initialize the library manager
library_manager = LibraryManager()

app = FastAPI(
    title="Calibre-AI Worker",
    description="A local worker for RAG with Ollama and phidata.",
    version="2.0.0",
)

# Mount static files for serving thumbnails
app.mount("/thumbnails", StaticFiles(directory="data/library/thumbnails"), name="thumbnails")

@app.get("/documents")
async def list_documents():
    """Lists all ingested documents with metadata and thumbnail information."""
    try:
        # Get documents from database (for chunk counts and ingestion info)
        db_documents = []
        try:
            db_documents = get_document_list_from_db()
        except ProgrammingError as e:
            if "does not exist" not in str(e):
                raise e
        
        # Get documents from library manager (for metadata and thumbnails)
        library_documents = library_manager.list_documents()
        
        # Merge the information
        documents = []
        
        for lib_doc in library_documents:
            doc_info = {
                "id": lib_doc["id"],
                "filename": lib_doc.get("title") or lib_doc["original_filename"],
                "original_filename": lib_doc["original_filename"],
                "author": lib_doc.get("author"),
                "page_count": lib_doc.get("page_count"),
                "file_size": lib_doc.get("file_size"),
                "file_extension": lib_doc.get("file_extension"),
                "added_at": lib_doc["added_at"],
                "chunk_count": 0,  # Default value
                "thumbnail_url": None
            }
            
            # Add thumbnail URL if available
            if lib_doc.get("thumbnail_path"):
                doc_info["thumbnail_url"] = f"/thumbnails/{lib_doc['id']}.jpg"
            
            # Try to find matching database document for chunk count using fuzzy matching
            matched_db_doc = None
            for db_doc in db_documents:
                # Try exact match first
                if db_doc["filename"] == lib_doc["original_filename"]:
                    matched_db_doc = db_doc
                    break
                # Try without extension
                elif db_doc["filename"] == lib_doc["original_filename"].rsplit('.', 1)[0]:
                    matched_db_doc = db_doc
                    break
                # Try the reverse (db has extension, library doesn't)
                elif lib_doc["original_filename"] == db_doc["filename"].rsplit('.', 1)[0]:
                    matched_db_doc = db_doc
                    break
            
            if matched_db_doc:
                doc_info["chunk_count"] = matched_db_doc.get("chunk_count", 0)
                doc_info["ingested_at"] = matched_db_doc.get("ingested_at")
            
            documents.append(doc_info)
        
        # Only include database documents that truly don't match any library documents (legacy)
        matched_db_filenames = set()
        for lib_doc in library_documents:
            for db_doc in db_documents:
                if (db_doc["filename"] == lib_doc["original_filename"] or 
                    db_doc["filename"] == lib_doc["original_filename"].rsplit('.', 1)[0] or
                    lib_doc["original_filename"] == db_doc["filename"].rsplit('.', 1)[0]):
                    matched_db_filenames.add(db_doc["filename"])
        
        for db_doc in db_documents:
            if db_doc["filename"] not in matched_db_filenames:
                documents.append({
                    "id": db_doc["id"],
                    "filename": db_doc["filename"],
                    "original_filename": db_doc["filename"],
                    "chunk_count": db_doc.get("chunk_count", 0),
                    "ingested_at": db_doc.get("ingested_at"),
                    "thumbnail_url": None
                })
        
        return documents
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

class ChatRequest(BaseModel):
    prompt: str

@app.post("/ingest")
async def ingest_document(file: UploadFile = File(...)):
    """
    Ingests a document, stores it permanently in the library, and processes it for RAG.
    Supports PDFs and eBooks with metadata extraction and thumbnail generation.
    """
    if not file.filename:
        raise HTTPException(status_code=400, detail="No file name provided.")

    # Create a temporary file for initial processing
    temp_dir = "data/temp"
    os.makedirs(temp_dir, exist_ok=True)
    temp_file_path = os.path.join(temp_dir, file.filename)

    try:
        # Save the uploaded file temporarily
        with open(temp_file_path, "wb") as buffer:
            shutil.copyfileobj(file.file, buffer)

        # Add document to library (this stores it permanently and extracts metadata)
        print(f"📚 Adding {file.filename} to library...")
        try:
            library_metadata = library_manager.add_document(temp_file_path, file.filename)
            print(f"✅ Successfully added to library: {library_metadata.get('title', file.filename)}")
        except Exception as library_error:
            print(f"❌ Error adding to library: {library_error}")
            raise HTTPException(
                status_code=500, 
                detail=f"Failed to add document to library: {str(library_error)}"
            )

        # Get the stored file path for knowledge base processing
        stored_file_path = library_manager.get_document_file_path(library_metadata["id"])
        
        if not stored_file_path or not stored_file_path.exists():
            raise HTTPException(status_code=500, detail="Document was not properly stored in library")

        # Copy the stored file to the knowledge base directory for processing
        kb_temp_dir = "data/pdf_files"
        os.makedirs(kb_temp_dir, exist_ok=True)
        kb_file_path = os.path.join(kb_temp_dir, file.filename)
        shutil.copy2(stored_file_path, kb_file_path)

        # Process with knowledge base
        try:
            print(f"📖 Processing {file.filename} with filtered PDF reader...")
            ingestion_agent = get_rag_agent()
            ingestion_agent.knowledge.load(recreate=False)
            print(f"✅ Successfully processed {file.filename} for RAG")
        except Exception as load_error:
            print(f"❌ Error processing for RAG: {load_error}")
            # Don't delete from library on RAG failure - the file is still stored
            print("⚠️ Document is stored in library but RAG processing failed")
            
        # Clean up knowledge base temp file
        if os.path.exists(kb_file_path):
            os.remove(kb_file_path)

        # Return success with library metadata
        return {
            "status": "success", 
            "message": f"Successfully ingested {library_metadata.get('title', file.filename)}", 
            "document_id": library_metadata["id"],
            "metadata": {
                "title": library_metadata.get("title"),
                "author": library_metadata.get("author"),
                "page_count": library_metadata.get("page_count"),
                "file_size": library_metadata.get("file_size"),
                "thumbnail_url": f"/thumbnails/{library_metadata['id']}.jpg" if library_metadata.get("thumbnail_path") else None
            }
        }

    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error during ingestion: {str(e)}")
    finally:
        # Clean up the temporary file
        if os.path.exists(temp_file_path):
            os.remove(temp_file_path)


@app.post("/chat/{document_id}")
async def chat_with_document(document_id: str, request: ChatRequest):
    """
    Handles chat with a specific document.
    Maintains a separate agent instance for each document_id to keep conversations isolated.
    document_id can be either a UUID or a filename for backward compatibility.
    """
    try:
        # Try to convert UUID to filename if needed
        if len(document_id) == 36 and '-' in document_id:  # Looks like a UUID
            filename = get_filename_from_uuid(document_id)
            # Use filename as the agent key for consistency
            agent_key = filename
        else:
            # Backward compatibility: document_id is already a filename
            agent_key = document_id
            
        if agent_key not in agents:
            # Create a new agent for this document's conversation with document-specific filtering
            agents[agent_key] = get_rag_agent(document_filter=agent_key)

        agent = agents[agent_key]
        response = agent.run(request.prompt)
        
        # Extract the actual text content from the phi agent response
        if hasattr(response, 'content'):
            response_text = response.content
        elif isinstance(response, dict) and 'content' in response:
            response_text = response['content']
        else:
            response_text = str(response)
        
        # Return the format expected by Flutter frontend
        return {
            "response": response_text,
            "conversation_id": agent_key,  # Use the document name as conversation ID
        }
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/health")
async def health_check():
    return {"status": "ok"}

if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True) 