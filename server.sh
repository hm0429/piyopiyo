#!/bin/bash

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is not installed"
    exit 1
fi

# Port number for the server
PORT=8000

# Start the server
echo "Starting server at http://localhost:$PORT"
echo "Press Ctrl+C to stop the server"
echo "Opening browser..."

# Open the browser and start the server
python3 -m http.server $PORT &
SERVER_PID=$!

# Wait a moment for the server to start
sleep 1

# Open the browser
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    open "http://localhost:$PORT/uuid/"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    xdg-open "http://localhost:$PORT/uuid/"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    # Windows
    start "http://localhost:$PORT/uuid/"
fi

# Wait for Ctrl+C
trap "kill $SERVER_PID; echo -e '\nServer stopped'; exit 0" INT
wait 