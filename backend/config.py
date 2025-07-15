"""
Configuration module for Calibre-AI backend.
Loads environment variables with secure defaults.
"""
import os
from dotenv import load_dotenv
from typing import Optional

# Load environment variables from .env file
load_dotenv()

class Config:
    """Application configuration from environment variables."""
    
    # Database Configuration
    POSTGRES_USER: str = os.getenv("POSTGRES_USER", "calibre_user")
    POSTGRES_PASSWORD: str = os.getenv("POSTGRES_PASSWORD", "secure_calibre_2024")
    POSTGRES_DB: str = os.getenv("POSTGRES_DB", "calibre_ai_db")
    POSTGRES_HOST: str = os.getenv("POSTGRES_HOST", "localhost")
    POSTGRES_PORT: str = os.getenv("POSTGRES_PORT", "5432")
    
    @classmethod
    def get_database_url(cls) -> str:
        """Construct database URL from environment variables."""
        return f"postgresql://{cls.POSTGRES_USER}:{cls.POSTGRES_PASSWORD}@{cls.POSTGRES_HOST}:{cls.POSTGRES_PORT}/{cls.POSTGRES_DB}"
    
    # Ollama Configuration
    OLLAMA_HOST: str = os.getenv("OLLAMA_HOST", "http://localhost:11434")
    CHAT_MODEL: str = os.getenv("CHAT_MODEL", "mistral:7b")
    EMBEDDING_MODEL: str = os.getenv("EMBEDDING_MODEL", "nomic-embed-text")
    
    # Application Settings
    LOG_LEVEL: str = os.getenv("LOG_LEVEL", "INFO")
    DEBUG: bool = os.getenv("DEBUG", "false").lower() == "true"
    
    # Security
    SECRET_KEY: str = os.getenv("SECRET_KEY", "dev-secret-key-change-in-production")
    JWT_SECRET: str = os.getenv("JWT_SECRET", "dev-jwt-secret-change-in-production")
    
    @classmethod
    def validate_config(cls) -> None:
        """Validate critical configuration values."""
        if cls.SECRET_KEY == "dev-secret-key-change-in-production":
            print("⚠️  WARNING: Using default SECRET_KEY. Set SECRET_KEY environment variable for production!")
        
        if cls.JWT_SECRET == "dev-jwt-secret-change-in-production":
            print("⚠️  WARNING: Using default JWT_SECRET. Set JWT_SECRET environment variable for production!")

# Create global config instance
config = Config()

# Validate config on import
config.validate_config()

# Convenience exports
DATABASE_URL = config.get_database_url()
OLLAMA_HOST = config.OLLAMA_HOST
CHAT_MODEL = config.CHAT_MODEL
EMBEDDING_MODEL = config.EMBEDDING_MODEL 