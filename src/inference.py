import os

import torch
from transformers import AutoModelForSequenceClassification, AutoTokenizer

MODEL_NAME = os.getenv("HF_MODEL_NAME")

tokenizer = AutoTokenizer.from_pretrained(MODEL_NAME)
model = AutoModelForSequenceClassification.from_pretrained(MODEL_NAME)


def predict(text):
    inputs = tokenizer(text, return_tensors="pt", truncation=True, padding=True)

    with torch.no_grad():
        logits = model(**inputs).logits
        return torch.argmax(logits, dim=1).item()


if __name__ == "__main__":
    TEXT = os.getenv("INPUT_TEXT", "This is a test sentence")

    # Print prediction details
    print("Model:", MODEL_NAME)
    print("Text:", TEXT)
    print("Prediction ID:", predict(TEXT))
    

