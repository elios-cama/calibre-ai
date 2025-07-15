from pydantic import BaseModel, Field
from typing import Optional
from uuid import UUID, uuid4

class ChatRequest(BaseModel):
    """Request model for chat endpoint"""
    query: str = Field(..., min_length=1, max_length=1000, description="User's question or query")
    agent_type: str = Field(default="pdf_assistant", description="Type of agent to use")
    conversation_id: Optional[str] = Field(default=None, description="Conversation ID for continuity")

class ChatResponse(BaseModel):
    """Response model for chat endpoint"""
    response: str = Field(..., description="AI assistant's response")
    conversation_id: str = Field(..., description="Conversation ID for tracking")

class HealthResponse(BaseModel):
    """Response model for health check"""
    status: str = Field(..., description="Service status")
    message: Optional[str] = Field(default=None, description="Additional status message")

class ErrorResponse(BaseModel):
    """Response model for errors"""
    error: str = Field(..., description="Error message")
    detail: Optional[str] = Field(default=None, description="Detailed error information") 