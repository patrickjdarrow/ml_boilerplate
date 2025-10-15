FROM pytorch/pytorch:2.8.0-cuda12.6-cudnn9-devel

# Install system dependencies
RUN apt-get update && apt-get install -y \
    vim \
    git \
    ffmpeg \
    libsm6 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages for VS Code notebook support
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir \
    ipykernel \
    jupyter \
    matplotlib \
    pandas \
    opencv-python \
    ffmpeg-python \
    ipywidgets \
    nbconvert \
    fiftyone

# Set working directory
WORKDIR /workspace

# Default command
CMD ["/bin/bash"]
