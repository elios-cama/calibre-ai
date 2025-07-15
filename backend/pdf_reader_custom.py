from typing import List
from phi.knowledge.pdf import PDFReader
from phi.document import Document
import logging

logger = logging.getLogger(__name__)

class FilteredPDFReader(PDFReader):
    """
    Custom PDF reader that filters out empty content chunks to prevent
    embedding dimension errors when processing PDFs with empty pages.
    """
    
    def read(self, pdf) -> List[Document]:
        """
        Read a PDF file and return a list of documents, filtering out empty content.
        
        Args:
            pdf: Path to the PDF file (str, Path, or file-like object)
            
        Returns:
            List of Document objects with non-empty content
        """
        try:
            # Get documents from parent class
            documents = super().read(pdf)
            
            # Filter out documents with empty or whitespace-only content
            filtered_documents = []
            empty_count = 0
            
            for doc in documents:
                if doc.content and doc.content.strip():
                    # Only keep documents with actual content
                    filtered_documents.append(doc)
                else:
                    empty_count += 1
                    logger.debug(f"Filtered out empty document from {pdf}")
            
            if empty_count > 0:
                logger.info(f"Filtered out {empty_count} empty documents from {pdf}")
            
            logger.info(f"Processed {pdf}: {len(filtered_documents)} valid documents (filtered {empty_count} empty)")
            
            return filtered_documents
            
        except Exception as e:
            logger.error(f"Error reading PDF {pdf}: {e}")
            return []
    
    def chunk_document(self, document: Document) -> List[Document]:
        """
        Override chunk_document to ensure chunks are also filtered for empty content.
        """
        try:
            # Get chunks from parent class
            chunks = super().chunk_document(document)
            
            # Filter out empty chunks
            filtered_chunks = []
            for chunk in chunks:
                if chunk.content and chunk.content.strip():
                    filtered_chunks.append(chunk)
            
            return filtered_chunks
            
        except Exception as e:
            logger.error(f"Error chunking document: {e}")
            return [] 