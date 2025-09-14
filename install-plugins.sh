roadiehq-backstage-plugin-argo-cd-backend-4.3.1

yarn install
yarn build
yarn dev



#!/bin/bash

set -e

# Base directories
ROOT_DIR="$HOME/rhdh"
PLUGINS_SRC="$ROOT_DIR/dynamic-plugins/wrappers"
PLUGINS_DEST="$ROOT_DIR/dynamic-plugins-root"

# Ensure destination exists
mkdir -p "$PLUGINS_DEST"

echo "Building and copying dynamic plugins..."

# Loop through all dynamic plugin folders
for plugin in "$PLUGINS_SRC"/*-dynamic; do
  if [ -d "$plugin" ]; then
    echo "Processing plugin: $(basename $plugin)"

    cd "$plugin"

    # Install dependencies
    echo "Installing dependencies..."
    yarn install || npm install

    # Build dynamic plugin (yarn or npm)
    echo "Building dynamic plugin..."
    if [ -f package.json ]; then
      if yarn build:dynamic >/dev/null 2>&1; then
        yarn build:dynamic
      else
        # fallback
        yarn build || npm run build
      fi
    fi

    # Get version from package.json
    VERSION=$(jq -r .version package.json)

    # Copy dist-dynamic to destination
    if [ -d dist-dynamic ]; then
      DEST_FOLDER="$PLUGINS_DEST/$(basename $plugin)-$VERSION"
      echo "Copying to $DEST_FOLDER"
      cp -r dist-dynamic "$DEST_FOLDER"
    else
      echo "Warning: dist-dynamic folder not found for $(basename $plugin)"
    fi
  fi
done

echo "All dynamic plugins built and copied successfully!"
