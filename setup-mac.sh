#!/bin/bash
# Mac Setup Script for Wizard Diver Game
# Run: chmod +x setup-mac.sh && ./setup-mac.sh

echo "=== Wizard Diver Game - Mac Setup ==="
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check and install Homebrew
echo -e "${YELLOW}Checking Homebrew installation...${NC}"
if command_exists brew; then
    BREW_VERSION=$(brew --version | head -n 1)
    echo -e "${GREEN}✓ Homebrew is installed: $BREW_VERSION${NC}"
else
    echo -e "${YELLOW}Homebrew not found. Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    
    if command_exists brew; then
        echo -e "${GREEN}✓ Homebrew installed successfully${NC}"
    else
        echo -e "${RED}✗ Homebrew installation failed. Please install manually from https://brew.sh${NC}"
        exit 1
    fi
fi

# Update Homebrew
echo ""
echo -e "${YELLOW}Updating Homebrew...${NC}"
brew update

# Check and install Git
echo ""
echo -e "${YELLOW}Checking Git installation...${NC}"
if command_exists git; then
    GIT_VERSION=$(git --version)
    echo -e "${GREEN}✓ Git is installed: $GIT_VERSION${NC}"
else
    echo -e "${YELLOW}Installing Git via Homebrew...${NC}"
    brew install git
    if command_exists git; then
        echo -e "${GREEN}✓ Git installed successfully${NC}"
    else
        echo -e "${RED}✗ Git installation failed${NC}"
        exit 1
    fi
fi

# Check and install Python (for content generation tools)
echo ""
echo -e "${YELLOW}Checking Python installation...${NC}"
if command_exists python3; then
    PYTHON_VERSION=$(python3 --version)
    echo -e "${GREEN}✓ Python is installed: $PYTHON_VERSION${NC}"
else
    echo -e "${YELLOW}Installing Python via Homebrew...${NC}"
    brew install python@3.12
    if command_exists python3; then
        echo -e "${GREEN}✓ Python installed successfully${NC}"
    else
        echo -e "${YELLOW}Python installation may have failed. Python 3 may already be installed via system.${NC}"
    fi
fi

# Check for Godot
echo ""
echo -e "${YELLOW}Checking Godot installation...${NC}"
GODOT_PATH=""

# Check common installation locations
if [ -d "/Applications/Godot.app" ]; then
    GODOT_PATH="/Applications/Godot.app"
elif [ -d "$HOME/Applications/Godot.app" ]; then
    GODOT_PATH="$HOME/Applications/Godot.app"
elif [ -f "$HOME/Downloads/Godot.app" ]; then
    GODOT_PATH="$HOME/Downloads/Godot.app"
elif command_exists godot; then
    GODOT_PATH=$(which godot)
fi

if [ -n "$GODOT_PATH" ]; then
    echo -e "${GREEN}✓ Godot found at: $GODOT_PATH${NC}"
else
    echo -e "${YELLOW}Godot not found. You'll need to install it manually:${NC}"
    echo -e "${CYAN}  1. Download Godot 4.x from: https://godotengine.org/download${NC}"
    echo -e "${CYAN}  2. Extract and move Godot.app to /Applications/${NC}"
    echo -e "${CYAN}  3. Optionally create a symlink for command-line access:${NC}"
    echo -e "${CYAN}     sudo ln -s /Applications/Godot.app/Contents/MacOS/Godot /usr/local/bin/godot${NC}"
fi

# Verify Git configuration
echo ""
echo -e "${YELLOW}Checking Git configuration...${NC}"
GIT_USER=$(git config --global user.name 2>/dev/null)
GIT_EMAIL=$(git config --global user.email 2>/dev/null)

if [ -n "$GIT_USER" ] && [ -n "$GIT_EMAIL" ]; then
    echo -e "${GREEN}✓ Git configured: $GIT_USER <$GIT_EMAIL>${NC}"
else
    echo -e "${YELLOW}Git user information not configured. Please set it:${NC}"
    echo -e "${CYAN}  git config --global user.name 'Your Name'${NC}"
    echo -e "${CYAN}  git config --global user.email 'your.email@example.com'${NC}"
fi

# Summary
echo ""
echo -e "${CYAN}=== Setup Summary ===${NC}"
echo -n "✓ Git: "
if command_exists git; then echo -e "${GREEN}Installed${NC}"; else echo -e "${RED}Not Found${NC}"; fi
echo -n "✓ Python: "
if command_exists python3; then echo -e "${GREEN}Installed${NC}"; else echo -e "${YELLOW}Not Found${NC}"; fi
echo -n "✓ Godot: "
if [ -n "$GODOT_PATH" ]; then echo -e "${GREEN}Found${NC}"; else echo -e "${YELLOW}Not Found - Install Manually${NC}"; fi

echo ""
echo -e "${CYAN}Next steps:${NC}"
echo -e "${NC}1. If Git wasn't configured, set your user name and email${NC}"
echo -e "${NC}2. Install Godot 4.x if not already installed${NC}"
echo -e "${NC}3. Clone the repository: git clone <repository-url>${NC}"
echo -e "${NC}4. Open the project in Godot: godot-project/project.godot${NC}"
echo ""
echo -e "${GREEN}Setup complete!${NC}"
