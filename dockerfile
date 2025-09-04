# Use Debian base image
FROM debian:bookworm-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3.11 python3.11-venv python3-pip git curl build-essential \
    libssl-dev libffi-dev zlib1g-dev libncurses5-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget xz-utils tk-dev \
    libxml2-dev libxmlsec1-dev liblzma-dev && \
    rm -rf /var/lib/apt/lists/*

# Make Python 3.11 default
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1

# Set working directory
WORKDIR /opt

# Clone NetExec repository
RUN git clone https://github.com/Pennyw0rth/NetExec.git

WORKDIR /opt/NetExec

# Create Python virtual environment
RUN python3 -m venv env

# Upgrade pip, setuptools, wheel
RUN . env/bin/activate && pip install --upgrade pip setuptools wheel

# Install Rust via rustup for building Rust-based Python wheels
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Install Python dependencies from pyproject.toml in editable mode
RUN . env/bin/activate && pip install -e .

# Install PyInstaller
RUN . env/bin/activate && pip install pyinstaller

# Build NetExec binary using PyInstaller (onedir mode)
RUN . env/bin/activate && pyinstaller --clean netexec.spec

# remove Rust and build tools to reduce final image size
RUN rm -rf /root/.cargo /root/.rustup && \
    apt-get remove -y build-essential curl && apt-get autoremove -y
