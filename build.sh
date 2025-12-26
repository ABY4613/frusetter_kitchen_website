#!/bin/bash
set -e

# Add Flutter to PATH
export PATH="$PATH:$HOME/flutter/bin"

# Verify Flutter is available
flutter --version

# Build the web app
flutter build web --release
