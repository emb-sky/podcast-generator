FROM ubuntu:latest

# Install Python and required build dependencies in one layer
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    python3-dev \
    git \
    gcc \
    libc-dev \
    && rm -rf /var/lib/apt/lists/*

# Install PyYAML
RUN pip3 install --no-cache-dir PyYAML

COPY feed.py /usr/bin/feed.py

COPY entrypoint.sh /entrypoint.sh

# Make sure entrypoint is executable
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]