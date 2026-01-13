---
name: wizard-diver-core-rules
description: Core rules and workflow guidelines for the Wizard Diver Godot project
---

# Wizard Diver – Complete Cursor Project Rules

These rules define **how Cursor must behave** when modifying this repository.  
All code, docs, and conversations must follow these rules.

---

# 1. Project Identity & Vision

1.1 The project is a **2D wizard/witch exploration + management game** inspired by **Dave the Diver**, replacing:
- Diving → Flying exploration  
- Sushi restaurant → Magic school management  
- Underwater enemies → Fantasy enemies  
- Upgrades → Spell progression & school upgrades  

1.2 The core loop:
- Explore magical biomes  
- Collect spells & treasures  
- Fight enemies  
- Unlock doors/areas  
- Return to a **magic school hub** to:
  - Teach classes  
  - Manage students/resources  
  - Upgrade spells/systems  
  - Progress story  

1.3 Priorities:
- Fun  
- Clean code  
- Modularity  
- Extensibility  
- Minimal bugs  
- Smooth gameplay  

---

# 2. Engine & Tech Rules

2.1 Engine: **Godot 4.x**, target **Godot 4.5.1**  
Do *not* upgrade engine versions unless explicitly told.

2.2 Scripting: **GDScript only**  
No C#, no external libraries unless requested.

2.3 Required Repository Structure (never change this):

wizard-diver-game/
├── .gitignore
├── README.md
├── CURRENT_STATUS.md
├── setup-windows.ps1
├── setup-mac.sh
├── docs/
│ ├── git-workflow.md
│ ├── game-design.md
│ └── art-pipeline.md
├── godot-project/
│ ├── project.godot
│ ├── scenes/
│ ├── scripts/
│ ├── assets/
│ └── exports/
└── tools/
└── content-generator/


2.4 Godot script folder structure must remain:
scripts/player/
scripts/enemies/
scripts/spells/
scripts/exploration/
scripts/ui/
scripts/school/
scripts/quests/
scripts/singletons/


2.5 Use autoload singletons for all major systems:
- GameManager  
- InputManager  
- SpellManager  
- SchoolManager  
- QuestManager  

---

# 3. Documentation Rules  
## (README.md & CURRENT_STATUS.md MUST always stay updated)

3.1 Every meaningful change must update:
- `README.md`
- `CURRENT_STATUS.md`

3.2 README update rules:
- Keep Development Phases accurate  
- Mark implemented items as **✅**  
- Mark active work as **⏳**  
- Do not lie about features  

3.3 CURRENT_STATUS.md update rules (MOST IMPORTANT):
- Must describe EXACTLY what the player sees when pressing F5  
- Must list working systems accurately  
- Must list Next Steps in priority order  
- Must update Quick Test Checklist when new gameplay is added  

3.4 Never mark a feature as working unless it:
- Exists in code  
- Works in gameplay  

3.5 Whenever adding features:
- Add them in README → Development Phases  
- Add them in CURRENT_STATUS → What’s Working  

---

# 4. Game Design & Consumer Experience Rules

4.1 Cursor must always consider the **player’s perspective**:
- Is this fun?  
- Is this readable?  
- Is this confusing?  
- Does this give good feedback?  

4.2 After **every feature** Cursor implements, it must suggest:
- 1–3 UX improvements  
- 1–3 polish upgrades  
- 1–3 content ideas  

All suggestions must be:
- Small  
- Optional  
- Scoped (30–60 minutes of dev time)  

4.3 Maintain fantasy tone:
- Spells  
- Wizards/Witches  
- Magic schools  
- Flying  
- Monsters  
- Magical environments  

4.4 Default controls (must stay synced in docs):
- WASD/Arrows = Move  
- TAB = Switch spells  
- 1–4 = Select/Cast  
- SPACE = Cast selected  
- E = Interact  
- ESC = Pause  

If controls change → update both docs immediately.

---

# 5. Implementation & Code Quality Rules

5.1 GDScript best practices:
- `snake_case` for variables & functions  
- `PascalCase` for nodes, scenes, resources  
- Typed variables and functions  
- Avoid deep inheritance  

5.2 Secure coding:
- Validate input  
- Check for nulls  
- Never silently fail  
- Never run external executables  
- Use Godot’s error logging  

5.3 Avoid magic numbers – use constants for:
- Spell damage  
- Enemy stats  
- Costs  
- Cooldowns  

5.4 Prefer **data-driven design** for:
- Spells  
- Enemies  
- Quests  
- NPCs  

5.5 Systems must be **modular**:
- Spell system independent from UI  
- Enemy AI not dependent on level structure  
- School manager decoupled from exploration gameplay  

5.6 Do not break:
- Start menu  
- Pause menu  
- Test level  
- Basic controls  

If you must, document it in both README + CURRENT_STATUS.

---

# 6. Cursor Behavior Rules

6.1 Always specify:
- File path  
- Whether new or modified  
- FULL file content (no partial diffs unless explicitly supported)  

6.2 Always update:
- README.md  
- CURRENT_STATUS.md  

6.3 After implementing a feature, Cursor must provide:
- Explanation of player interaction  
- Directions for testing the feature  
- At least one suggestion for improvement  

6.4 For UI:
- Clean node hierarchy  
- Scripts in `scripts/ui/`  
- Update CURRENT_STATUS → UI sections  
- Add test steps to Quick Test Checklist  

---

# 7. Error Handling & Stability

7.1 Do not introduce new errors or warnings.  
If unavoidable, explain:
- Why they exist  
- Whether they affect gameplay  
- How to resolve them  

7.2 If modifying a working script:
- Ensure it still compiles  
- Ensure autoloads remain valid  

7.3 New autoloads or signals:
- Must be documented in CURRENT_STATUS.md  

---

# 8. Suggested Features (Always-On Mode)

Cursor must ALWAYS think of ways to improve:
- UX feedback  
- Spell feel  
- Combat smoothness  
- Exploration clarity  
- School/town management loop  

After each change, suggest:
- 1 new enemy idea  
- 1 new spell idea  
- 1 new quest idea  
- 1 small polish idea  

---

# 9. File & Path Integrity Rules

Paths that must always remain valid:

- `godot-project/scripts/player/player.gd`  
- `godot-project/scripts/ui/start_menu.gd`  
- `godot-project/scripts/ui/pause_menu.gd`  
- `godot-project/scenes/start_menu.tscn`  
- `godot-project/scenes/pause_menu.tscn`  
- `godot-project/scenes/test_level.tscn`  
- `godot-project/scripts/spells/`  
- `godot-project/scripts/enemies/`  
- `godot-project/scripts/school/`  
- `godot-project/scripts/quests/`  
- `godot-project/scripts/singletons/`  

If moved or renamed:
- Update ALL references  
- Update CURRENT_STATUS paths  

---

# 10. Testing & Performance Rules

10.1 Every new system must consider:
- FPS  
- Stutter  
- GC spikes  
- Particles  
- AI overhead  

10.2 If adding expensive features:
- Update CURRENT_STATUS → Quick Test Checklist  
- Add testing instructions  

---

# 11. Git Workflow Rule (always active)

Cursor must ALWAYS remember this workflow:

git add .
git commit -m "Description of changes"
git push origin main


When ending a task, Cursor must remind the user if they need to push changes.

---

# END OF RULE FILE
