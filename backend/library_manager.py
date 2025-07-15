import os
import uuid
import shutil
import json
import io
from pathlib import Path
from typing import Dict, Any, Optional, List
import logging
from datetime import datetime

# PDF and image processing
import fitz  # PyMuPDF
from PIL import Image
import pdf2image
from pypdf import PdfReader

# eBook processing
import ebooklib
from ebooklib import epub

logger = logging.getLogger(__name__)

class LibraryManager:
    """
    Manages the document library similar to Calibre:
    - Stores original files in organized folders
    - Extracts metadata (title, author, etc.)
    - Generates thumbnails from first page/cover
    - Maintains database records
    """
    
    def __init__(self, library_path: str = "data/library"):
        self.library_path = Path(library_path)
        self.library_path.mkdir(parents=True, exist_ok=True)
        
        # Create subdirectories
        self.documents_path = self.library_path / "documents"
        self.thumbnails_path = self.library_path / "thumbnails"
        self.metadata_path = self.library_path / "metadata"
        
        for path in [self.documents_path, self.thumbnails_path, self.metadata_path]:
            path.mkdir(exist_ok=True)
    
    def add_document(self, file_path: str, original_filename: str) -> Dict[str, Any]:
        """
        Add a document to the library with proper storage and metadata extraction.
        
        Args:
            file_path: Temporary path to the uploaded file
            original_filename: Original filename from upload
            
        Returns:
            Dictionary with document metadata and paths
        """
        try:
            # Generate unique document ID
            doc_id = str(uuid.uuid4())
            
            # Determine file type
            file_extension = Path(original_filename).suffix.lower()
            supported_types = {'.pdf', '.epub', '.mobi', '.azw', '.azw3'}
            
            if file_extension not in supported_types:
                raise ValueError(f"Unsupported file type: {file_extension}")
            
            # Create document folder
            doc_folder = self.documents_path / doc_id
            doc_folder.mkdir(exist_ok=True)
            
            # Copy file to library with clean name
            clean_filename = self._clean_filename(original_filename)
            stored_file_path = doc_folder / clean_filename
            shutil.copy2(file_path, stored_file_path)
            
            # Extract metadata
            metadata = self._extract_metadata(stored_file_path, file_extension)
            metadata.update({
                'id': doc_id,
                'original_filename': original_filename,
                'stored_filename': clean_filename,
                'file_extension': file_extension,
                'added_at': datetime.now().isoformat(),
                'file_size': os.path.getsize(stored_file_path)
            })
            
            # Generate thumbnail
            thumbnail_path = self._generate_thumbnail(stored_file_path, doc_id, file_extension)
            if thumbnail_path:
                metadata['thumbnail_path'] = str(thumbnail_path.relative_to(self.library_path))
            
            # Save metadata
            metadata_file = self.metadata_path / f"{doc_id}.json"
            with open(metadata_file, 'w', encoding='utf-8') as f:
                json.dump(metadata, f, indent=2, ensure_ascii=False)
            
            logger.info(f"✅ Successfully added document: {metadata.get('title', original_filename)}")
            return metadata
            
        except Exception as e:
            logger.error(f"❌ Error adding document {original_filename}: {e}")
            raise
    
    def _extract_metadata(self, file_path: Path, file_extension: str) -> Dict[str, Any]:
        """Extract metadata from PDF or eBook files."""
        metadata = {
            'title': None,
            'author': None,
            'subject': None,
            'creator': None,
            'producer': None,
            'creation_date': None,
            'modification_date': None,
            'page_count': None,
            'language': None,
            'publisher': None,
            'isbn': None,
            'description': None
        }
        
        try:
            if file_extension == '.pdf':
                metadata.update(self._extract_pdf_metadata(file_path))
            elif file_extension in ['.epub', '.mobi', '.azw', '.azw3']:
                metadata.update(self._extract_ebook_metadata(file_path, file_extension))
                
        except Exception as e:
            logger.warning(f"⚠️ Could not extract metadata from {file_path}: {e}")
        
        return metadata
    
    def _extract_pdf_metadata(self, file_path: Path) -> Dict[str, Any]:
        """Extract metadata from PDF files."""
        metadata = {}
        
        try:
            # Try PyMuPDF first (more reliable)
            pdf_doc = fitz.open(str(file_path))
            pdf_metadata = pdf_doc.metadata
            
            metadata.update({
                'title': pdf_metadata.get('title'),
                'author': pdf_metadata.get('author'),
                'subject': pdf_metadata.get('subject'),
                'creator': pdf_metadata.get('creator'),
                'producer': pdf_metadata.get('producer'),
                'creation_date': pdf_metadata.get('creationDate'),
                'modification_date': pdf_metadata.get('modDate'),
                'page_count': pdf_doc.page_count
            })
            
            pdf_doc.close()
            
        except Exception as e:
            logger.warning(f"⚠️ PyMuPDF metadata extraction failed, trying PyPDF: {e}")
            
            try:
                # Fallback to PyPDF
                with open(file_path, 'rb') as f:
                    pdf_reader = PdfReader(f)
                    pdf_info = pdf_reader.metadata
                    
                    if pdf_info:
                        metadata.update({
                            'title': pdf_info.get('/Title'),
                            'author': pdf_info.get('/Author'),
                            'subject': pdf_info.get('/Subject'),
                            'creator': pdf_info.get('/Creator'),
                            'producer': pdf_info.get('/Producer'),
                            'creation_date': pdf_info.get('/CreationDate'),
                            'modification_date': pdf_info.get('/ModDate'),
                            'page_count': len(pdf_reader.pages)
                        })
                        
            except Exception as e2:
                logger.warning(f"⚠️ PyPDF metadata extraction also failed: {e2}")
        
        return metadata
    
    def _extract_ebook_metadata(self, file_path: Path, file_extension: str) -> Dict[str, Any]:
        """Extract metadata from eBook files."""
        metadata = {}
        
        try:
            if file_extension == '.epub':
                book = epub.read_epub(str(file_path))
                
                metadata.update({
                    'title': book.get_metadata('DC', 'title')[0][0] if book.get_metadata('DC', 'title') else None,
                    'author': book.get_metadata('DC', 'creator')[0][0] if book.get_metadata('DC', 'creator') else None,
                    'publisher': book.get_metadata('DC', 'publisher')[0][0] if book.get_metadata('DC', 'publisher') else None,
                    'language': book.get_metadata('DC', 'language')[0][0] if book.get_metadata('DC', 'language') else None,
                    'description': book.get_metadata('DC', 'description')[0][0] if book.get_metadata('DC', 'description') else None,
                    'isbn': book.get_metadata('DC', 'identifier')[0][0] if book.get_metadata('DC', 'identifier') else None,
                })
                
        except Exception as e:
            logger.warning(f"⚠️ eBook metadata extraction failed: {e}")
        
        return metadata
    
    def _generate_thumbnail(self, file_path: Path, doc_id: str, file_extension: str) -> Optional[Path]:
        """Generate thumbnail from PDF first page or eBook cover."""
        thumbnail_path = self.thumbnails_path / f"{doc_id}.jpg"
        
        try:
            if file_extension == '.pdf':
                return self._generate_pdf_thumbnail(file_path, thumbnail_path)
            elif file_extension in ['.epub', '.mobi', '.azw', '.azw3']:
                return self._generate_ebook_thumbnail(file_path, thumbnail_path, file_extension)
                
        except Exception as e:
            logger.warning(f"⚠️ Could not generate thumbnail for {file_path}: {e}")
            return None
    
    def _generate_pdf_thumbnail(self, file_path: Path, thumbnail_path: Path) -> Optional[Path]:
        """Generate thumbnail from PDF first page."""
        try:
            # Try PyMuPDF first (faster)
            pdf_doc = fitz.open(str(file_path))
            if pdf_doc.page_count == 0:
                pdf_doc.close()
                return None
                
            # Get first page
            page = pdf_doc[0]
            
            # Render page to image (200 DPI for good quality)
            mat = fitz.Matrix(200/72, 200/72)  # 200 DPI scaling
            pix = page.get_pixmap(matrix=mat)
            
            # Convert to PIL Image
            img_data = pix.tobytes("ppm")
            img = Image.open(io.BytesIO(img_data))
            
            # Resize to standard thumbnail size (300x400, maintaining aspect ratio)
            img.thumbnail((300, 400), Image.Resampling.LANCZOS)
            
            # Save as JPEG
            img.save(thumbnail_path, "JPEG", quality=85, optimize=True)
            
            pdf_doc.close()
            logger.info(f"✅ Generated PDF thumbnail: {thumbnail_path}")
            return thumbnail_path
            
        except Exception as e:
            logger.warning(f"⚠️ PyMuPDF thumbnail failed, trying pdf2image: {e}")
            
            try:
                # Fallback to pdf2image
                pages = pdf2image.convert_from_path(
                    str(file_path), 
                    first_page=1, 
                    last_page=1,
                    dpi=200,
                    fmt='RGB'
                )
                
                if pages:
                    img = pages[0]
                    img.thumbnail((300, 400), Image.Resampling.LANCZOS)
                    img.save(thumbnail_path, "JPEG", quality=85, optimize=True)
                    
                    logger.info(f"✅ Generated PDF thumbnail with pdf2image: {thumbnail_path}")
                    return thumbnail_path
                    
            except Exception as e2:
                logger.warning(f"⚠️ pdf2image thumbnail also failed: {e2}")
                return None
    
    def _generate_ebook_thumbnail(self, file_path: Path, thumbnail_path: Path, file_extension: str) -> Optional[Path]:
        """Generate thumbnail from eBook cover."""
        try:
            if file_extension == '.epub':
                book = epub.read_epub(str(file_path))
                
                # Look for cover image
                for item in book.get_items():
                    if item.get_type() == ebooklib.ITEM_COVER or 'cover' in item.get_name().lower():
                        img = Image.open(io.BytesIO(item.get_content()))
                        img.thumbnail((300, 400), Image.Resampling.LANCZOS)
                        img.save(thumbnail_path, "JPEG", quality=85, optimize=True)
                        
                        logger.info(f"✅ Generated eBook thumbnail: {thumbnail_path}")
                        return thumbnail_path
                        
        except Exception as e:
            logger.warning(f"⚠️ eBook thumbnail generation failed: {e}")
            
        return None
    
    def _clean_filename(self, filename: str) -> str:
        """Clean filename for safe storage."""
        # Remove or replace problematic characters
        import re
        cleaned = re.sub(r'[<>:"/\\|?*]', '_', filename)
        cleaned = re.sub(r'\s+', '_', cleaned)  # Replace spaces with underscores
        return cleaned[:100]  # Limit length
    
    def get_document_metadata(self, doc_id: str) -> Optional[Dict[str, Any]]:
        """Get metadata for a specific document."""
        metadata_file = self.metadata_path / f"{doc_id}.json"
        
        if metadata_file.exists():
            try:
                with open(metadata_file, 'r', encoding='utf-8') as f:
                    return json.load(f)
            except Exception as e:
                logger.error(f"❌ Error reading metadata for {doc_id}: {e}")
        
        return None
    
    def list_documents(self) -> List[Dict[str, Any]]:
        """List all documents in the library."""
        documents = []
        
        for metadata_file in self.metadata_path.glob("*.json"):
            try:
                with open(metadata_file, 'r', encoding='utf-8') as f:
                    metadata = json.load(f)
                    documents.append(metadata)
            except Exception as e:
                logger.warning(f"⚠️ Could not read metadata file {metadata_file}: {e}")
        
        # Sort by added date (newest first)
        documents.sort(key=lambda x: x.get('added_at', ''), reverse=True)
        return documents
    
    def get_document_file_path(self, doc_id: str) -> Optional[Path]:
        """Get the file path for a document."""
        metadata = self.get_document_metadata(doc_id)
        if metadata:
            return self.documents_path / doc_id / metadata['stored_filename']
        return None
    
    def get_thumbnail_path(self, doc_id: str) -> Optional[Path]:
        """Get the thumbnail path for a document."""
        thumbnail_path = self.thumbnails_path / f"{doc_id}.jpg"
        return thumbnail_path if thumbnail_path.exists() else None
    
    def remove_document(self, doc_id: str) -> bool:
        """Remove a document from the library."""
        try:
            # Remove document folder
            doc_folder = self.documents_path / doc_id
            if doc_folder.exists():
                shutil.rmtree(doc_folder)
            
            # Remove thumbnail
            thumbnail_path = self.thumbnails_path / f"{doc_id}.jpg"
            if thumbnail_path.exists():
                thumbnail_path.unlink()
            
            # Remove metadata
            metadata_file = self.metadata_path / f"{doc_id}.json"
            if metadata_file.exists():
                metadata_file.unlink()
            
            logger.info(f"✅ Removed document {doc_id} from library")
            return True
            
        except Exception as e:
            logger.error(f"❌ Error removing document {doc_id}: {e}")
            return False 