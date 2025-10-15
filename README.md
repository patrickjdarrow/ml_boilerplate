# ML Development Environment

A containerized deep-learning based computer vision development environment with GPU acceleration support and built around VS Code.

## Purpose

This template provides a ML development setup to avoid common environment configuration hassles like dependency conflicts and CUDA compatibility problems.

## Components

- **[PyTorch](https://pytorch.org/)**: CUDA-enabled deep learning framework
- **[VS Code Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)**: Containerized development environments
- **[FiftyOne](https://voxel51.com/docs/fiftyone/)**: Computer vision dataset exploration and visualization
- **[IPython Kernel](https://ipython.readthedocs.io/en/stable/install/kernel_install.html)**: Notebook execution in VS Code with GPU access
- **[NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/overview.html)**: GPU passthrough to containers

## Prerequisites

Required on host system:

- **Docker**: ([install guide](https://docs.docker.com/get-docker/))
- **NVIDIA GPU**: With current drivers
- **VS Code**: With Dev Containers extension ([install guide](https://code.visualstudio.com/docs/devcontainers/tutorial))
- **NVIDIA Container Toolkit**: For GPU access in containers ([install guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html))

## Usage

Create a new project from this template:
```bash
git clone https://github.com/patrickjdarrow/boilerplateML.git your-project-name
cd your-project-name

# Initialize as new repository
rm -rf .git
git init
```

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
4. Begin development
5. After adding and commiting changes, connect to your repository
```
git remote add origin https://github.com/yourusername/your-project-name.git
git push -u origin main
```