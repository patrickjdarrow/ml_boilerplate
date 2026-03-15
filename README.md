# ML Development Environment

A containerized deep-learning based computer vision development environment with GPU acceleration support and built around VS Code.

## Purpose

This template provides a ML development setup to avoid common environment configuration hassles like dependency conflicts and CUDA compatibility problems.

## Components

- **[PyTorch](https://pytorch.org/)**: CUDA-enabled deep learning framework
- **[VS Code Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)**: Containerized development environments
- **[uv](https://docs.astral.sh/uv/)**: Fast Python package manager — dependencies declared in `pyproject.toml`, pinned in `uv.lock`
- **[Claude Code](https://claude.ai/code)**: AI-assisted development, pre-installed in the container
- **[FiftyOne](https://voxel51.com/docs/fiftyone/)**: Computer vision dataset exploration and visualization
- **[ruff](https://docs.astral.sh/ruff/)**: Fast Python linter and formatter
- **[NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/overview.html)**: GPU passthrough to containers

## Prerequisites

Required on host system:

- **Docker**: ([install guide](https://docs.docker.com/get-docker/))
- **NVIDIA GPU**: With current drivers
- **VS Code**: With Dev Containers extension ([install guide](https://code.visualstudio.com/docs/devcontainers/tutorial))
- **NVIDIA Container Toolkit**: For GPU access in containers ([install guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html))
- **uv**: For updating dependencies ([install guide](https://docs.astral.sh/uv/getting-started/installation/))

## Usage

Create a new project from this template:

```bash
# Option 1: GitHub UI — click "Use this template" on the repo page

# Option 2: CLI
git clone https://github.com/patrickjdarrow/ml_boilerplate.git your-project-name
cd your-project-name
bash setup.sh your-project-name
```

`setup.sh` replaces the project name in `pyproject.toml`, reinitializes git, and prints next steps.

### Configuration

Edit `config.env` to modify settings:

```bash
# Data directory on host (mounted to /data in container)
DATA_DIR=${HOME}/data
```

Project files are mounted to `/workspace` in the container. Data files from the configured directory are available at `/data`.

### Development

1. Open project folder in VS Code
2. In the command palette select "Dev Containers: Reopen in Container"
3. Wait for container build (first time only)
4. Begin development — the `ml-env` Jupyter kernel and Claude Code are ready to use

### Adding Dependencies

```bash
# 1. Edit pyproject.toml — add packages to [project.dependencies]
# 2. Regenerate the lockfile
uv lock
# 3. Commit both files, then rebuild the container
git add pyproject.toml uv.lock
git commit -m "add <package>"
# Dev Containers: Rebuild Container
```

**Do not add `torch` to `pyproject.toml`** — it is provided by the base Docker image with the correct CUDA build.

### Connecting to a Remote Repository

```bash
git remote add origin https://github.com/yourusername/your-project-name.git
git push -u origin main
```
