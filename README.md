# Wizard Diver Game

A 2D wizard exploration game inspired by Dave the Diver, where players fly through magical environments (cities, castles, dungeons) collecting spells, managing a magic school, and progressing through an AI-generated story.

## Project Overview

- **Engine:** Godot 4.x
- **Language:** GDScript
- **Platform:** Windows, Mac, Linux
- **Timeline:** 3 months for polished MVP

## Quick Start

### First Time Setup

#### Windows
1. Run `setup-windows.ps1` in PowerShell (as Administrator if needed)
2. This will install Git, Godot dependencies, and verify installations

#### Mac
1. Run `chmod +x setup-mac.sh`
2. Run `./setup-mac.sh`
3. This will install Homebrew (if needed), Git, Godot dependencies, and verify installations

### Daily Workflow

#### Starting a Work Session
1. Pull latest changes: `git pull origin main`
2. Open the project in Godot: Open `godot-project/project.godot`

#### During Development
- Work on features
- Test locally in Godot
- Commit frequently: `git add .` → `git commit -m "your message"`

#### Ending a Work Session
1. Commit any changes: `git add .` → `git commit -m "description of changes"`
2. Push to GitHub: `git push origin main`

See [docs/git-workflow.md](docs/git-workflow.md) for detailed Git workflow instructions.

## Project Structure

```
wizard-diver-game/
├── .gitignore
├── README.md
├── setup-windows.ps1
├── setup-mac.sh
├── docs/
│   ├── git-workflow.md
│   ├── game-design.md
│   └── art-pipeline.md
├── godot-project/          # Main game project
│   ├── project.godot
│   ├── scenes/
│   ├── scripts/
│   ├── assets/
│   └── exports/
└── tools/                  # Helper scripts
    └── content-generator/  # AI content generation tools
```

## Development Phases

1. **Phase 1:** Project Setup & Infrastructure ✅
2. **Phase 2:** Core Game Systems (Weeks 1-4)
3. **Phase 3:** Gameplay Systems (Weeks 5-8)
4. **Phase 4:** Content & Polish (Weeks 9-12)
5. **Phase 5:** Build & Deployment

## Requirements

- Godot Engine 4.x
- Git
- Python 3.x (for content generation tools)

## Contributing

This is a solo project, but follow the Git workflow guidelines in `docs/git-workflow.md` when working across multiple machines.

## License

TBD
