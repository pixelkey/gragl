# GraphRag Ollama Local
GraphRag and Local LLMs. Stay tuned for more updates.
This project aims to provide a way to effectively implement a GraphRag solution that is cost effective and simple to work with.
It is meant to provide a good head start without having to develop something from scratch.

## Installation
This installation is meant for linux.

### 0. Install prerequisits

Ollama

Poetry

### 1. Clone repo where you want to install it
git clone https://github.com/pixelkey/gragl.git && cd gragl

### 2. Create a virtual environment using Python 3.11.8
conda create -n gragl python=3.11.8 -y

### 3. Activate the virtual environment
conda activate gragl

### 4. Run install.sh file. This will also install poetry if you don't have it installed already
./install.sh

### 5. Add input files to ingest 
Place an example text file into ./indexing/input or use the examples already there.

### 6. Run the graphrag indexing
python3 -m graphrag.index --root ./indexing

Note: If you don't have enough data/files available, it might fail with an error like this: WARNING Graph has no nodes


## Other Commands - Deactivate and Uninstall

### To deactivate
conda deactivate

### If you need to uninstall/remove conda 
conda remove --name gragl --all


## Troubleshooting
In order to get it working locally, a hack was needed to replace the way openai_embeddings_llm.py works.
For more information and other potential updates regarding this hack, refer to the following:

https://github.com/microsoft/graphrag/issues/345
