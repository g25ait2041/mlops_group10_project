FROM python:3.10-slim

WORKDIR /app

ARG HF_MODEL_NAME=ishant-ai/mlops-group10-goodreads-genre-classifier
ENV HF_MODEL_NAME=$HF_MODEL_NAME

# system deps (important for scientific python packages)
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# upgrade pip first (VERY important for torch/transformers installs)
RUN pip install --no-cache-dir --upgrade pip

# install torch first (CPU version)
RUN pip install --no-cache-dir torch --index-url https://download.pytorch.org/whl/cpu

# install remaining dependencies INCLUDING numpy explicitly
COPY requirements.txt .

RUN pip install --no-cache-dir numpy
RUN pip install --no-cache-dir -r requirements.txt

COPY src/ src/

ENV PYTHONUNBUFFERED=1

CMD ["python", "src/inference.py"]