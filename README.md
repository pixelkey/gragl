# GraphRag Ollama Local

GraphRag and Local LLMs. Stay tuned for more updates.
This project aims to provide a way to effectively implement a GraphRag solution that is cost effective and simple to work with.
It is meant to provide a good head start without having to develop something from scratch.

## Installation
This installation is meant for Linux.

### 0. Install prerequisites

- Ollama: https://ollama.com/
- Poetry: https://python-poetry.org/

### 1. Clone the repository where you want to install it

```bash
git clone https://github.com/pixelkey/gragl.git && cd gragl
```

### 2. Make install.sh executable

```bash
chmod +x install.sh
```

By default, install.sh might not be executable. This command ensures it can be run directly.

### 3. Create a virtual environment using Python 3.11.8

```bash
conda create -n gragl python=3.11.8 -y
```

### 4. Activate the virtual environment

```bash
conda activate gragl
```

### 5. Run the install.sh file.

```bash
./install.sh
```

### 6. Add input files to ingest

Place your text files into ./indexing/input or use the examples already there.

### 7. Run the GraphRag indexing

```bash
python3 -m graphrag.index --root ./indexing
```
Reference: https://microsoft.github.io/graphrag/posts/config/init/

### 8 Prompt Tuning - optional
You can auto-tune your prompts to be more relevant to your content's domain.
Note: The output folder populated from the last step is needed for this to work.
```bash
python3 -m graphrag.prompt_tune --root ./indexing --config ./indexing/settings.yaml --no-entity-types
```
Reference: https://microsoft.github.io/graphrag/posts/prompt_tuning/auto_prompt_tuning/

After reviewing the prompt updates and if you are happy with the results, re-run the indexing (step 7).

### Query 
Reference: https://microsoft.github.io/graphrag/posts/query/overview/


---

## Other Commands - Deactivate and Uninstall

### To deactivate

```bash
conda deactivate
```

### If you need to uninstall/remove the Conda environment

```bash
conda remove --name gragl --all
```

---

## Troubleshooting

In order to get it working locally, a hack was needed to replace the way openai_embeddings_llm.py works. For more information and other potential updates regarding this hack, refer to the following:

https://github.com/microsoft/graphrag/issues/345

### GPU Requirements
Let's be honest, GraphRag requires some serious LLM grunt. Trying to get away with something like Mistral:7b is just not going to cut it.
The results will be subpar and simply not worth it. You need to use something like mistral-nemo or mistral-nemo:12b-instruct-2407-fp16.

### Not enough data
If you don't have enough data/files available, it might fail with an error like this:
WARNING: Graph has no nodes.