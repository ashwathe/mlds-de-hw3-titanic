# Titanic Data Engineering Project

This project demonstrates containerized data engineering and machine learning pipelines in **Python** and **R** using the Titanic dataset.  
The goal is to practice reproducible data processing, model training, and deployment inside Docker containers, ensuring that anyone can reproduce the results with minimal setup.

---

## Project Structure
'''
mlds-de-hw3-titanic/
├── data/ # Folder for Titanic CSVs (train.csv, test.csv)
│ └── README.md # Instructions for downloading data
├── src/ # Python pipeline
│ └── main.py # Data cleaning, logistic regression, predictions
├── src_r/ # R pipeline
│ ├── main.R # R version of the model pipeline
│ └── install_packages.R # Installs required R libraries
├── models/ # Folder for saved models (optional)
├── outputs/ # Predictions saved from both containers
├── Dockerfile # Python container definition
├── src_r/Dockerfile # R container definition
├── requirements.txt # Python dependencies
├── .gitignore # Ignored files and folders
└── README.md # Project documentation

'''
---

## Overview

The project runs **two independent pipelines (Python and R)** to predict passenger survival on the Titanic dataset.

### **Python Container**
- Loads and preprocesses `/data/train.csv`
- Removes duplicates, fills missing values, and encodes categorical variables
- Trains a logistic regression model using **scikit-learn**
- Saves predictions to `outputs/predictions.csv`

### **R Container**
- Loads and processes `/data/train.csv` using **tidyverse**
- Handles missing values and performs logistic regression using **caret**
- Saves predictions to `outputs/predictions_R.csv`

---

## Setup Instructions

### 1️. Clone the Repository
git clone https://github.com/ashwathe/mlds-de-hw3-titanic.git
cd mlds-de-hw3-titanic

### 2. Download the Titanic Dataset 
Place them inside your /data directory:
mlds-de-hw3-titanic/
└── data/
    ├── train.csv
    ├── test.csv
    └── gender_submission.csv

### 3. Build the Docker Image (Python)
docker build -t mlds-titanic -f Dockerfile .

### 4. Run the container (Python)
docker run --rm \
  -v "$PWD/data:/app/data" \
  -v "$PWD/models:/app/models" \
  -v "$PWD/outputs:/app/outputs" \
  mlds-titanic

The output should look like this:
Data loaded successfully. Shape: (891, 12)
Duplicates removed. Shape: (891, 12)
Missing values handled.
Model trained successfully.
Predictions saved to predictions.csv

### 5. Build the Docker Image (R)
docker build -t mlds-titanic-r -f src_r/Dockerfile .

### 6. Run the container (R)
docker run --rm \
  -v "$PWD/data:/app/data" \
  -v "$PWD/outputs:/app/outputs" \
  mlds-titanic-r

The output should look like this:
Packages installed successfully.
Data loaded successfully.
Model trained successfully.
Predictions saved to predictions_R.csv

### 7. How to Reproduce
1. Clone the repository: git clone https://github.com/ashwathe/mlds-de-hw3-titanic.git
2. Add Titanic CSV files to /data/
3. Build and run both Docker containers (Python and R)
4. Verify generated prediction files in /outputs/:
outputs/predictions.csv       # from Python model
outputs/predictions_R.csv     # from R model



