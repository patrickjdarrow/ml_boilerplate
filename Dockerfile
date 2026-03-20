FROM pytorch/pytorch:2.10.0-cuda13.0-cudnn9-devel

# System dependencies
# Note: git and gh are installed via devcontainer features (see .devcontainer/devcontainer.json)
RUN apt-get update && apt-get install -y --no-install-recommends \
    vim \
    ffmpeg \
    libsm6 \
    libxext6 \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js LTS + Claude Code CLI
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g @anthropic-ai/claude-code \
    && rm -rf /var/lib/apt/lists/*

# Install uv (fast Python package manager)
ENV UV_INSTALL_DIR=/usr/local/bin
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Install Python deps from lockfile into /opt/venv.
# Separate COPY from source code preserves Docker layer cache:
# if only your code changes (not pyproject.toml/uv.lock), this layer is reused.
#
# NOTE: PyTorch is NOT in pyproject.toml — it comes from the base image with
# the correct CUDA build. Re-adding it here would install a CPU-only version.
COPY pyproject.toml uv.lock /opt/project/
ENV UV_PROJECT_ENVIRONMENT=/opt/venv
RUN cd /opt/project && uv sync --frozen

# Make the venv the default Python for all shells
ENV PATH="/opt/venv/bin:$PATH"

WORKDIR /workspace
CMD ["/bin/bash"]
