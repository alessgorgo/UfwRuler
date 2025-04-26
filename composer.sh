#!/bin/bash

TITLE="UfwRuler Composer"

echo "[$TITLE] Starting environment setup..."

# 1. Install required system packages
echo "[$TITLE] Checking required packages..."
if [ -f "./packages/requirements.txt" ]; then
    while IFS= read -r package
    do
        if ! dpkg -s "$package" >/dev/null 2>&1; then
            echo "[$TITLE] Installing missing package: $package"
            sudo apt-get install -y "$package"
        else
            echo "[$TITLE] Package $package already installed."
        fi
    done < "./packages/requirements.txt"
else
    echo "[$TITLE] No requirements.txt file found! Skipping package installation."
fi

# 2. Set script permissions
echo "[$TITLE] Setting executable permissions..."
chmod +x setup.sh
chmod +x templates/*.sh

# 3. Offer to start setup
read -p "[$TITLE] Environment ready. Start UfwRuler now? (y/n): " start_now

if [[ "$start_now" =~ ^[Yy]$ ]]; then
    ./setup.sh
else
    echo "[$TITLE] You can run it manually later with ./setup.sh"
fi
