#!/bin/bash

# Clone the GraphRag repository
git clone https://github.com/microsoft/graphrag.git

# Navigate into the graphrag directory
cd graphrag

# Check if poetry is installed, if not, install it
if ! command -v poetry &> /dev/null
then
    echo "Poetry could not be found. Installing poetry..."
    curl -sSL https://install.python-poetry.org | python3 -
    export PATH="$HOME/.local/bin:$PATH"
else
    echo "Poetry is already installed"
fi

# Install dependencies using poetry (from pyproject.toml)
poetry install

# Initialize the indexing folder using graphrag.index
poetry run python3 -m graphrag.index --init --root ../indexing

# Go back to the parent directory (root of graphrag repo) for the pip install step
cd ..

# Install the repository in editable mode
pip install -e ./graphrag

# Replace the file in the graphrag folder structure with the override file
echo "Replacing openai_embeddings_llm.py with the override version..."
cp ./overrides/graphrag/graphrag/llm/openai/openai_embeddings_llm.py ./graphrag/graphrag/llm/openai/openai_embeddings_llm.py

# Install requirements.txt
pip install -r requirements.txt

ollama pull mistral
ollama pull nomic-embed-text
