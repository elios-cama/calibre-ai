#!/usr/bin/env python3
"""
Example usage script following Phi documentation patterns
This demonstrates how to use the PDF knowledge base directly
"""

import os
from dotenv import load_dotenv
from phi.agent import Agent
from phi.model.google import Gemini
from knowledge_base import get_knowledge_base

# Load environment variables
load_dotenv()

def main():
    """Example usage following Phi documentation"""
    
    # Check for required environment variables
    if not os.getenv("GOOGLE_API_KEY"):
        print("❌ Please set GOOGLE_API_KEY environment variable")
        return
    
    print("🚀 Starting PDF RAG example...")
    
    # Get the knowledge base
    knowledge_base = get_knowledge_base()
    
    if knowledge_base is None:
        print("❌ Failed to initialize knowledge base")
        return
    
    # Load the knowledge base (following Phi docs pattern)
    print("📖 Loading knowledge base...")
    try:
        knowledge_base.load(recreate=False)
        print("✅ Knowledge base loaded successfully")
    except Exception as e:
        print(f"⚠️ Warning loading knowledge base: {e}")
        try:
            knowledge_base.load()
            print("✅ Knowledge base loaded on retry")
        except Exception as retry_error:
            print(f"❌ Failed to load knowledge base: {retry_error}")
            return
    
    # Create agent following Phi documentation pattern
    agent = Agent(
        name="PDF Assistant Example",
        model=Gemini(
            id="gemini-2.5-flash-preview-05-20",
            api_key=os.getenv("GOOGLE_API_KEY")
        ),
        knowledge=knowledge_base,
        search_knowledge=True,
        instructions=[
            "You are a helpful assistant that answers questions based on PDF documents.",
            "Always search the knowledge base first for relevant information.",
            "Provide accurate answers based on the PDF content.",
            "If information is not available, clearly state this."
        ],
        markdown=True,
        show_tool_calls=True,
    )
    
    # Example queries
    example_queries = [
        "What are the main topics covered in the documents?",
        "Can you summarize the key points from the PDFs?",
        "What specific information is available in the knowledge base?"
    ]
    
    print("\n🤖 PDF Assistant is ready! Here are some example queries:")
    for i, query in enumerate(example_queries, 1):
        print(f"{i}. {query}")
    
    print("\n" + "="*50)
    print("Interactive mode - type 'quit' to exit")
    print("="*50)
    
    # Interactive loop
    while True:
        try:
            user_input = input("\n💬 Ask a question about your PDFs: ").strip()
            
            if user_input.lower() in ['quit', 'exit', 'q']:
                print("👋 Goodbye!")
                break
            
            if not user_input:
                continue
            
            print("\n🔍 Searching knowledge base and generating response...")
            response = agent.run(user_input)
            
            print(f"\n🤖 Assistant: {response.content}")
            
        except KeyboardInterrupt:
            print("\n👋 Goodbye!")
            break
        except Exception as e:
            print(f"\n❌ Error: {e}")

if __name__ == "__main__":
    main() 