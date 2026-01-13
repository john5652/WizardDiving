# Quick Start Guide

## First Time Setup

### 1. Install Dependencies

**Windows:**
```powershell
# Run as Administrator (right-click PowerShell > Run as Administrator)
.\setup-windows.ps1
```

**Mac:**
```bash
chmod +x setup-mac.sh
./setup-mac.sh
```

### 2. Set Up GitHub Repository

1. Create a new repository on GitHub (see `docs/git-workflow.md` for details)
2. Initialize git in this directory:
   ```bash
   git init
   git remote add origin https://github.com/YOUR_USERNAME/wizard-diver-game.git
   git add .
   git commit -m "Initial project setup"
   git push -u origin main
   ```

### 3. Install Godot

- Download Godot 4.x from https://godotengine.org/download
- **Windows:** Extract to a folder (e.g., `C:\Godot`)
- **Mac:** Move `Godot.app` to `/Applications`

### 4. Open Project

**Windows:**
- Open Godot
- Click "Import" and select `godot-project/project.godot`
- Or double-click `project.godot` if Godot is associated with .godot files

**Mac:**
```bash
open -a Godot godot-project/project.godot
```

### 5. Run the Game

- In Godot, press `F5` or click the "Play" button
- You should see a blue square (player) that you can move with WASD/Arrow keys

## Daily Workflow

### Starting Work Session

1. **Pull latest changes:**
   ```bash
   git pull origin main
   ```

2. **Open project in Godot**

### During Development

- Make changes
- Test in Godot (F5)
- Commit frequently:
  ```bash
  git add .
  git commit -m "Description of changes"
  ```

### Ending Work Session

1. **Commit and push:**
   ```bash
   git add .
   git commit -m "Description of work done"
   git push origin main
   ```

## Project Structure

- `godot-project/` - Main game project
- `docs/` - Documentation
- `tools/` - Helper scripts and tools
- `setup-windows.ps1` / `setup-mac.sh` - Setup scripts
- `build-windows.ps1` / `build-mac.sh` - Build scripts

## Key Controls

- **Movement:** WASD or Arrow Keys
- **Interact:** Space
- **Cast Spell 1-4:** Number keys 1-4

## Next Steps

1. Read `docs/game-design.md` for game design details
2. Read `docs/git-workflow.md` for Git workflow
3. Read `docs/art-pipeline.md` for art integration
4. Start building your game!

## Getting Help

- Godot Documentation: https://docs.godotengine.org
- Godot Forums: https://forum.godotengine.org
- Project README: See `README.md`
