FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    python3-dev \
    git \
    gcc \
    libc-dev \
    && rm -rf /var/lib/apt/lists/*

# Option 1: Use --break-system-packages (not recommended but works)
# RUN pip3 install --no-cache-dir --break-system-packages PyYAML

# Option 2: Use a virtual environment (recommended)
RUN python3 -m pip install --upgrade pip
RUN pip3 install --no-cache-dir virtualenv
RUN python3 -m virtualenv /opt/venv
# Make sure we use the virtualenv
ENV PATH="/opt/venv/bin:$PATH"
# Now install PyYAML in the virtualenv
RUN pip install --no-cache-dir PyYAML

COPY feed.py /usr/bin/feed.py

COPY entrypoint.sh /entrypoint.sh

# Make sure entrypoint is executable
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
