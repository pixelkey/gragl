#!/bin/bash

# Clone the GraphRag repository
git clone https://github.com/microsoft/graphrag.git

# Navigate into the graphrag directory
cd graphrag

# Check if poetry is installed, if not, notify the user and exit
if ! command -v poetry &> /dev/null
then
    echo "Error: Poetry could not be found. Please install poetry before running this script."
    echo "Visit https://python-poetry.org/docs/#installation for installation instructions."
    exit 1
else
    echo "Poetry is already installed"
fi

# Install dependencies using poetry (from pyproject.toml)
poetry install

# Rename the indexing folder to avoid conflicts with the graphrag package
mv ../indexing ../init/indexing

# Initialize the indexing folder using graphrag.index
poetry run python3 -m graphrag.index --init --root ../indexing

# Go back to the parent directory (root of graphrag repo) for the pip install step
cd ..

# Install the repository in editable mode
pip install -e ./graphrag

# Automatically replace or add files from the init folder to the project
echo "Processing files from init folder..."

# Loop through all files in the init folder and copy them to the corresponding locations in the project
find ./init -type f | while read src_file; do
    # Determine the relative path of the file in the init directory
    relative_path="${src_file#./init/}"

    # Define the corresponding target file path in the project directory
    target_file="./$relative_path"

    # Check if the target file exists
    if [ -f "$target_file" ]; then
        # If the file exists, replace it
        echo "Replacing $target_file with $src_file"
        cp "$src_file" "$target_file"
    else
        # If the file doesn't exist, add it
        echo "Adding new file $target_file from $src_file"
        # Create the directory structure if it doesn't exist
        mkdir -p "$(dirname "$target_file")"
        # Copy the new file
        cp "$src_file" "$target_file"
    fi
done

# We no longer need the init/indexing folder
rm -rf ./init/indexing

# Install dependencies from requirements.txt
pip install -r requirements.txt

# Pull the required models using ollama
ollama pull mistral-nemo:12b-instruct-2407-fp16
ollama pull nomic-embed-text
