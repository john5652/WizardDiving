# Wizard Diver Game

A 2D wizard exploration game inspired by Dave the Diver, where players fly through magical environments (cities, castles, dungeons) collecting spells, managing a magic school, and progressing through an AI-generated story.

## Vision

**Wizard Diver** aims to combine the satisfying exploration and management loop of Dave the Diver with the spell-casting and progression systems of classic action-adventure games. The core vision is to create a game where:

- **Exploration feels magical**: Players glide smoothly through diverse magical biomes, discovering secrets and collecting spells that feel rewarding to find
- **Combat is strategic**: With limited spell slots, players must choose their loadout carefully and use spells creatively to overcome challenges
- **Progression is meaningful**: Managing the magic school provides a satisfying meta-game that enhances exploration capabilities and unlocks new content
- **Story emerges naturally**: AI-generated quests and NPCs create a dynamic narrative that makes each playthrough feel unique

The game should feel polished and complete, with smooth controls, satisfying feedback, and enough content for a 5-10 hour playthrough. While inspired by Dave the Diver's structure, it should have its own identity as a magical exploration game with deep spell-casting mechanics.

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
2. **Phase 2:** Core Game Systems ✅ (In Progress)
   - ✅ Player movement with smooth acceleration
   - ✅ Input system
   - ✅ Start menu
   - ✅ Pause menu
   - ✅ Health system
   - ✅ Camera system
3. **Phase 3:** Gameplay Systems (In Progress)
   - ✅ Spell system framework
   - ✅ Spell collection & casting
   - ✅ Enemy system
   - ✅ Door/unlock system
   - ✅ Test level
   - ⏳ School management UI
   - ⏳ Quest system UI
4. **Phase 4:** Content & Polish (Planned)
5. **Phase 5:** Build & Deployment (Planned)

## Requirements

- Godot Engine 4.x
- Git
- Python 3.x (for content generation tools)

## Contributing

This is a solo project, but follow the Git workflow guidelines in `docs/git-workflow.md` when working across multiple machines.

## License

TBD
