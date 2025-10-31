# Use a lightweight Python image
FROM python:3.11-slim

# Environment variables for faster & cleaner installs
ENV PIP_NO_CACHE_DIR=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set the working directory inside the container
WORKDIR /app

# Copy only the requirements first (for better layer caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the source code into the image
COPY src/ src/

# Create directories for data, models, and outputs
RUN mkdir -p /app/data /app/models /app/outputs

# Default command to run your script
CMD ["python", "src/main.py", "--data-dir", "data", "--model-path", "models/model.joblib", "--out", "outputs/predictions.csv"]
