# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**ml_boilerplate** is a template repository for GPU-accelerated ML/computer vision development. Users clone it to start new projects with a pre-configured containerized environment. It is not a runnable application — it's a starting point.

## Development Workflow

This project is designed exclusively around VS Code Dev Containers:

1. Edit `config.env` to set `DATA_DIR` (host path mounted to `/data` in container)
2. Open in VS Code → "Dev Containers: Reopen in Container"
3. First build pulls `pytorch/pytorch:2.8.0-cuda12.6-cudnn9-devel` and installs Python packages
4. The `postCreateCommand` registers the IPython kernel as `ml-env` for notebook use

There is no Makefile, docker-compose, or test suite — this is intentional for a template.

## Container Architecture

| Host path | Container path | Purpose |
|---|---|---|
| Project root | `/workspace` | Source code (bind mount) |
| `$DATA_DIR` (default: `~/data`) | `/data` | Training/inference data |

**GPU**: `hostRequirements.gpu: true` enforces GPU availability. Container runs as `root`.

**FiftyOne** (dataset visualization) is served on port 5151, forwarded automatically.

## Stack

- **Base image**: `pytorch/pytorch:2.8.0-cuda12.6-cudnn9-devel`
- **Package manager**: `uv` — packages declared in [pyproject.toml](pyproject.toml), pinned in `uv.lock`
- **Key packages**: PyTorch (base image), ipykernel, jupyter, pandas, matplotlib, opencv-python, ffmpeg-python, fiftyone
- **Dev tools**: ruff (lint/format)
- **VS Code extensions**: ms-python.python, ms-toolsai.jupyter, voxel51.fiftyone, anthropics.claude-code, charliermarsh.ruff
- **Python venv**: `/opt/venv` (built into the image; `PATH` is set automatically)

**Note:** PyTorch is not in `pyproject.toml`. It comes from the base image with the correct CUDA build — adding it would install a CPU-only version.

## Extending the Template

When adding to this template, the typical structure users add:

```
├── notebooks/       # Jupyter notebooks (use ml-env kernel)
├── src/             # Training/inference Python code
├── models/          # Saved checkpoints
└── config.env       # Already present — configure DATA_DIR here
```

**To add Python dependencies:**
1. Edit `[project.dependencies]` in [pyproject.toml](pyproject.toml)
2. Run `uv lock` (updates `uv.lock`)
3. Commit both `pyproject.toml` and `uv.lock`
4. "Dev Containers: Rebuild Container"

To add system packages, extend the `apt-get install` block in [Dockerfile](Dockerfile). Changes take effect on container rebuild.