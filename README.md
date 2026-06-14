# MLOps Group 10 — Goodreads Book Genre Classifier

An end-to-end MLOps project that trains and deploys a **book genre classification model** using the Goodreads dataset and HuggingFace Transformers. The trained model is hosted on HuggingFace Hub and served via a Dockerized inference pipeline, with automated CI through GitHub Actions.
# Project Links
Kaggle Notebook	https://www.kaggle.com/code/ishantkulshreshtha/mlops-group10-project
Hugging Face Model	https://huggingface.co/ishant-ai/mlops-group10-goodreads-genre-classifier
W&B Dashboard	https://wandb.ai/ishantkul86-iit-j/mlops_group10_project
W&B Report	https://wandb.ai/ishantkul86-iit-j/mlops_group10_project/reports/MlOps-Group-10-project---VmlldzoxNzE1MDI4Mg
GHCR (Docker Image)	Package mlops_group10_project · GitHub

---

## Table of Contents

- [Project Overview](#project-overview)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Running Inference](#running-inference)
- [Docker Usage](#docker-usage)
- [CI/CD Pipeline](#cicd-pipeline)
- [Model](#model)
- [Team](#team)

---

## Project Overview

Given a book's description or title text, the model predicts its **genre** (e.g., Fantasy, Mystery, Romance, etc.). The project demonstrates a full MLOps lifecycle:

- Fine-tuning a pre-trained transformer model for sequence classification
- Hosting the model on HuggingFace Hub
- Packaging the inference pipeline in Docker
- Enforcing code quality via GitHub Actions CI

---

## Tech Stack

| Category | Tools |
|---|---|
| Model | HuggingFace Transformers (`AutoModelForSequenceClassification`) |
| Framework | PyTorch |
| Data | HuggingFace Datasets, Scikit-learn |
| Containerization | Docker (Python 3.10-slim) |
| CI | GitHub Actions + flake8 |
| Model Registry | HuggingFace Hub |

**Python dependencies** (`requirements.txt`):
```
torch
transformers
datasets
scikit-learn
requests
tqdm
numpy
```

---

## Project Structure

```
mlops_group10_project/
├── src/
│   └── inference.py          # Load model from HF Hub and run predictions
├── .github/
│   └── workflows/
│       └── ci.yml            # Linting CI on push/PR
│       └── inference.yml     # inference pipeline for running model
├── Dockerfile                # Container definition for inference
├── requirements.txt          # Python dependencies
└── README.md
```

---

## Getting Started

### Prerequisites

- Python 3.10+
- pip
- Docker (optional, for containerized inference)

### Installation

```bash
git clone https://github.com/g25ait2041/mlops_group10_project.git
cd mlops_group10_project

pip install --upgrade pip
pip install -r requirements.txt
```

### Running Inference

Set the required environment variables and run the inference script:

```bash
export HF_MODEL_NAME=ishant-ai/mlops-group10-goodreads-genre-classifier
export INPUT_TEXT="A young wizard discovers he has magical powers and enrolls in a school for witches and wizards."

python src/inference.py
```

**Expected output:**
```
Model: ishant-ai/mlops-group10-goodreads-genre-classifier
Text: A young wizard discovers he has magical powers...
Prediction ID: <genre_label_id>
```

---

## Docker Usage

### Build the image

```bash
docker build -t mlops-group10-inference .
```

You can override the model at build time:

```bash
docker build \
  --build-arg HF_MODEL_NAME=ishant-ai/mlops-group10-goodreads-genre-classifier \
  -t mlops-group10-inference .
```

### Run inference in a container

```bash
docker run \
  -e INPUT_TEXT="A detective investigates a series of mysterious murders in 1920s London." \
  mlops-group10-inference
```

### Override the model at runtime

```bash
docker run \
  -e HF_MODEL_NAME=ishant-ai/mlops-group10-goodreads-genre-classifier \
  -e INPUT_TEXT="Your book description here" \
  mlops-group10-inference
```

---

## CI/CD Pipeline

The project uses **GitHub Actions** for continuous integration.

**Trigger conditions:**
- Push to the `develop` branch
- Pull requests targeting `main`

**CI steps:**
1. Checkout code
2. Set up Python 3.11
3. Install `flake8`
4. Lint `src/` with a max line length of 120 characters

```yaml
# .github/workflows/ci.yml
on:
  push:
    branches: [develop]
  pull_request:
    branches: [main]
```

All PRs must pass linting before being merged into `main`.

---

## Model

The trained model is publicly available on HuggingFace Hub:

**`ishant-ai/mlops-group10-goodreads-genre-classifier`**

- Architecture: `AutoModelForSequenceClassification` (transformer-based)
- Task: Multi-class book genre classification
- Dataset: Goodreads

The model is loaded dynamically at runtime via the `HF_MODEL_NAME` environment variable, making it easy to swap in updated model versions without changing the inference code.

---

## Team

**MLOps Group 10** — Academic MLOps project.
## Team Members

| Roll Number | Name |
|------------|------|
| G25AIT2111 | Soumya A |
| G25AIT2041 | Ishant Kulshreshtha |
| G25AIT2011 | Ankit Purohit |
| G25AIT2080 | Rajesh Gopal |

---

## 🔗 Project Resources

| Platform | Link |
| :--- | :--- |
| **Kaggle Notebook** | [View on Kaggle](https://www.kaggle.com/code/ishantkulshreshtha/mlops-group10-project) |
| **Hugging Face Model** | [View on Hugging Face](https://huggingface.co/ishant-ai/mlops-group10-goodreads-genre-classifier) |
| **W&B Dashboard** | [View on W&B](https://wandb.ai/ishantkul86-iit-j/mlops_group10_project) |
| **W&B Report** | [View Report](https://wandb.ai/ishantkul86-iit-j/mlops_group10_project/reports/MlOps-Group-10-project---VmlldzoxNzE1MDI4Mg) |
| **Docker Image** | [View on GHCR](https://github.com/g25ait2041/mlops_group10_project/pkgs/container/mlops_group10_project) |

## 📄 Documentation
* **Project Report:** Completed.

--

## License

This project is for educational purposes. See individual library licenses for dependency terms.
