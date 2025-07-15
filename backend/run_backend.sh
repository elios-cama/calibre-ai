#!/bin/bash
# This script starts the backend server with the correct environment for Apple Silicon Macs
# to ensure it finds the homebrew-installed PostgreSQL library.

# Get the full path to the project's backend directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Activate the virtual environment
source "$DIR/venv/bin/activate"

# Set the dynamic library path to Homebrew's postgresql@16 library
export DYLD_LIBRARY_PATH="/usr/local/opt/postgresql@16/lib:$DYLD_LIBRARY_PATH"

echo "Starting backend server..."
uvicorn main:app --host 127.0.0.1 --port 8000 --reload