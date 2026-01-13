#!/bin/bash
# Mac Build Script for Wizard Diver Game
# Builds the game for Mac platform

GODOT_PATH=""
EXPORT_PRESET="Mac OSX"

echo "=== Wizard Diver Game - Mac Build ==="
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

# Find Godot if path not provided
if [ -z "$GODOT_PATH" ]; then
    if [ -d "/Applications/Godot.app" ]; then
        GODOT_PATH="/Applications/Godot.app/Contents/MacOS/Godot"
    elif [ -d "$HOME/Applications/Godot.app" ]; then
        GODOT_PATH="$HOME/Applications/Godot.app/Contents/MacOS/Godot"
    elif command -v godot >/dev/null 2>&1; then
        GODOT_PATH=$(which godot)
    fi
fi

if [ -z "$GODOT_PATH" ] || [ ! -f "$GODOT_PATH" ]; then
    echo -e "${RED}Godot not found. Please specify path:${NC}"
    echo -e "${YELLOW}  ./build-mac.sh GODOT_PATH=/path/to/Godot${NC}"
    exit 1
fi

echo -e "${GREEN}Using Godot: $GODOT_PATH${NC}"
echo ""

# Create builds directory
BUILDS_DIR="builds/mac"
mkdir -p "$BUILDS_DIR"

# Build the game
echo -e "${YELLOW}Building game...${NC}"

PROJECT_PATH="godot-project/project.godot"
EXPORT_PATH=$(cd "$BUILDS_DIR" && pwd)

# Note: This requires export presets to be configured in Godot
echo ""
echo -e "${CYAN}To build the game:${NC}"
echo -e "${NC}1. Open Godot and load: $PROJECT_PATH${NC}"
echo -e "${NC}2. Go to Project > Export${NC}"
echo -e "${NC}3. Add 'Mac OSX' export preset${NC}"
echo -e "${NC}4. Configure export settings${NC}"
echo -e "${NC}5. Click 'Export Project' and choose: $BUILDS_DIR/WizardDiver.app${NC}"
echo ""
echo -e "${CYAN}Or use command line (after configuring export):${NC}"
echo -e "${NC}  $GODOT_PATH --headless --export-release 'Mac OSX' '$EXPORT_PATH/WizardDiver.app'${NC}"

echo ""
echo -e "${GREEN}Build script ready!${NC}"
