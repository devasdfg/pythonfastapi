# Use Python 3.12 Bullseye as base image
FROM python:3.12-slim-bullseye

# install system dependencies
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    build-essential \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# set the working directory in the container
WORKDIR /app

# copy requirements first for better caching
COPY requirements.txt .

# install python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# copy source codes to the image
COPY ./app .

# expose the port 8000
EXPOSE 8000

# run the command to start uvicorn
CMD ["uvicorn", "main_fastapi:app", "--host", "0.0.0.0", "--port", "8000", "--workers", "4"]