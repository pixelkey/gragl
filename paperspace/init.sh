#!/bin/bash


# Place and run this file from the root of the project directory "notebooks"

# Change to /notebooks directory
cd /notebooks

# Clone the GraphRag repository if it does not exist
if [ ! -d "graphrag" ]; then
    git clone https://github.com/pixelkey/gragl.git
fi

# Define the Ollama model directory
MODEL_DIR="/notebooks/ollama_models"

# Create the Ollama model directory if it doesn't exist
mkdir -p "$MODEL_DIR"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Ollama is installed
if command_exists ollama; then
    echo "Ollama is already installed."
else
    echo "Ollama not found. Installing Ollama..."
    curl -fsSL https://ollama.com/install.sh | sh
fi

# Check if Poetry is installed
if command_exists poetry; then
    echo "Poetry is already installed."
else
    echo "Poetry not found. Installing Poetry..."
    curl -sSL https://install.python-poetry.org | python3 -
    # Add Poetry to PATH
    export PATH="$HOME/.local/bin:$PATH"
fi

# Set the OLLAMA_MODELS environment variable
export OLLAMA_MODELS="$MODEL_DIR"

# Check if 'ollama serve' is already running
if pgrep -f "ollama serve" > /dev/null; then
    echo "Ollama serve is already running."
else
    # Start Ollama serve in the background with the environment variable set
    OLLAMA_MODELS="$MODEL_DIR" ollama serve &
    # Wait for Ollama service to start
    sleep 5
fi

# Define the models you want to use
MODELS=(
  "mistral-nemo:12b-instruct-2407-fp16"
  "nomic-embed-text"
  # Add more models here, one per line
)

# Pull models if they don't already exist
for MODEL_NAME in "${MODELS[@]}"; do
  if [ ! -d "$MODEL_DIR/$MODEL_NAME" ]; then
    echo "Model $MODEL_NAME not found in $MODEL_DIR. Pulling model..."
    OLLAMA_MODELS="$MODEL_DIR" ollama pull "$MODEL_NAME"
  else
    echo "Model $MODEL_NAME already exists in $MODEL_DIR."
  fi
done

# Clone gragl repository if it does not exist
if [ ! -d "gragl" ]; then
  git clone https://github.com/pixelkey/gragl.git
fi

# Change directory to gragl
cd gragl

# Make install.sh executable
chmod +x install.sh

# Run install.sh
./install.sh