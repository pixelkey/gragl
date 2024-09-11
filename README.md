# GraphRag Local
GraphRag and Local LLMs. Stay tuned for more updates.
This project aims to provide a way to effectively implement a GraphRag solution that is cost effective and simple to work with.
It is meant to provide a good head start without having to develop something from scratch.

## Installation

### 1. Create a virtual environment using Python 3.11.9
conda create -n gragl python=3.11.9 -y

### 2. Activate the virtual environment
conda activate gragl

### 3. Run install.sh file. This will also install poetry if you don't have it installed already
./install.sh

### 4. Place an example text file into ./indexing/input

### 5. Run the graphrag indexing
python3 -m graphrag.index --root ./indexing





## Other Commands - Deactivate and Uninstall

### To deactivate
conda deactivate

### If you need to uninstall/remove conda 
conda remove --name graphrag-local --all