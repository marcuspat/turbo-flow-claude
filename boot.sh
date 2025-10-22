#!/bin/bash
set -e

echo "Cloning repository..."
git clone https://github.com/marcuspat/turbo-flow-claude.git

echo "Moving devpods directory..."
mv turbo-flow-claude/devpods .

echo "Cleaning up clone..."
rm -rf turbo-flow-claude

echo "Making scripts executable..."
chmod +x ./devpods/*.sh

echo "Running codespace_setup.sh..."
./devpods/codespace_setup.sh

echo "Script completed!"
