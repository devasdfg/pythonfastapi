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


# expose the port 5001
EXPOSE 5001

# run the command to start uvicorn
CMD ["uvicorn", "main_fastapi:app", "--host", "0.0.0.0", "--port", "5001"]