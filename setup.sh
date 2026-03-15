#!/usr/bin/env bash
# Run once after cloning to initialize as a new project.
# Usage: bash setup.sh [project-name]
#   project-name defaults to the current directory name.
set -euo pipefail

PROJECT_NAME="${1:-$(basename "$PWD")}"

echo "Initializing project: $PROJECT_NAME"
sed -i "s/name = \"ml-project\"/name = \"$PROJECT_NAME\"/" pyproject.toml

rm -rf .git
git init
git add .
git commit -m "Initial commit from ml_boilerplate"

echo ""
echo "Done. Next steps:"
echo "  1. Edit pyproject.toml to add dependencies, then run 'uv lock'"
echo "  2. Open in VS Code and 'Dev Containers: Reopen in Container'"
echo "  3. Connect your remote: git remote add origin <url>"
