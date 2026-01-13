# Next Steps Action Plan
## Wizard Diver Game - Immediate Implementation Guide

**Based on:** Comprehensive project review and consumer-focused analysis  
**Goal:** Complete the Dave the Diver exploration → return → upgrade loop

---

## 🎯 Top 3 Critical Next Steps

### 1. **Level Transition System** 🔴 START HERE
**Time:** 4-5 hours  
**Priority:** CRITICAL - Blocks everything else

**What to Build:**
- Level Hub Scene (where player selects where to explore)
- School Hub Scene (physical school, not just menu)
- 3-5 Biome Scenes (using available backgrounds)
- Scene transition system

**Files to Create/Modify:**
- `scenes/level_hub.tscn` (NEW)
- `scenes/school_hub.tscn` (NEW)
- `scenes/dark_forest_level.tscn` (NEW - use `forest_001_1920x1080.png`)
- `scenes/dungeon_level.tscn` (NEW - use `fantasy_002_1920x1080.png`)
- `scenes/village_level.tscn` (NEW - use `village_004_1920x1080.png`)
- `scripts/singletons/game_manager.gd` (MODIFY - add scene transitions)
- `scripts/ui/level_hub_ui.gd` (NEW)

**Implementation Steps:**
1. Create `level_hub.tscn` with buttons for each biome
2. Create `school_hub.tscn` with background and "Go Explore" button
3. Duplicate `test_level.tscn` for each biome
4. Update each biome's `room.gd` to load appropriate background
5. Add "Return to School" button in exploration areas
6. Update `GameManager` to handle scene transitions

---

### 2. **Material Collection System** 🔴 HIGH PRIORITY
**Time:** 3-4 hours  
**Priority:** HIGH - Completes exploration loop

**What to Build:**
- Material pickup system (similar to spell pickups)
- Material inventory UI
- Material types: Herbs, Crystals, Monster Parts, Ancient Runes
- Connect materials to school upgrades

**Files to Create/Modify:**
- `scripts/exploration/material_pickup.gd` (NEW)
- `scripts/ui/material_inventory_ui.gd` (NEW)
- `scripts/singletons/material_manager.gd` (NEW)
- `scenes/material_pickup.tscn` (NEW)
- `scripts/school/school_manager.gd` (MODIFY - add material requirements)
- `scenes/magic_school.tscn` (MODIFY - show material requirements)

**Implementation Steps:**
1. Create `MaterialPickup` script (copy from `SpellPickup`)
2. Create material types dictionary
3. Create material inventory UI (similar to spell inventory)
4. Auto-collect monster parts on enemy death
5. Update school upgrades to require materials
6. Add material display to school UI

---

### 3. **School Hub Scene** 🔴 HIGH PRIORITY
**Time:** 5-6 hours  
**Priority:** HIGH - Creates "home base" feeling

**What to Build:**
- Physical school scene (not just menu)
- NPCs (Headmaster, Students, Shopkeeper, Librarian)
- Dialogue system
- Visual school upgrades

**Files to Create/Modify:**
- `scenes/school_hub.tscn` (NEW - physical school)
- `scripts/npcs/npc.gd` (NEW)
- `scripts/npcs/dialogue_system.gd` (NEW)
- `scripts/ui/dialogue_ui.gd` (NEW)
- `scenes/dialogue_box.tscn` (NEW)
- Use available NPC sprites from `assets/sprites/characters/npcs/`

**Implementation Steps:**
1. Create school hub scene with background (`village_004_1920x1080.png`)
2. Add NPC nodes using available sprites
3. Create simple dialogue system (text boxes)
4. Add "Go Explore" button to level hub
5. Make school visually upgradeable (show upgrades in scene)
6. Connect NPCs to quest system

---

## 🎨 Asset Integration Plan

### Backgrounds to Use (Currently Unused)

1. **Dark Forest Biome**
   - Background: `forest_001_1920x1080.png`
   - Theme: Mystical forest, hidden paths
   - Enemies: Goblins, maybe bats
   - Materials: Herbs, rare crystals

2. **Dungeon Biome**
   - Background: `fantasy_002_1920x1080.png` or `fantasy_005_1920x1080.png`
   - Theme: Dark dungeons, ancient ruins
   - Enemies: Goblins, bats (flying enemies)
   - Materials: Ancient runes, monster parts
   - Props: Use `magical_seal_archway.png` for boss areas

3. **Village/Other School Biome**
   - Background: `village_004_1920x1080.png`
   - Theme: Friendly village, other magic schools
   - Enemies: Fewer enemies, more NPCs
   - Materials: Trading materials, quest items

4. **School Hub**
   - Background: `village_004_1920x1080.png` (interior version or create one)
   - Theme: Safe haven, home base
   - NPCs: Headmaster, Students, Shopkeeper, Librarian
   - Features: Upgrade displays, material storage

---

### Enemies to Integrate

1. **Bat Enemy** (Currently Unused)
   - File: `bat_enemy.png` (10-frame spritesheet)
   - Location: `assets/sprites/environment/dungeons/characters/`
   - Behavior: Flying enemy, swoop attacks, faster than goblin
   - Use in: Dungeon and mystical biomes
   - Implementation: Create `bat_enemy.gd` (similar to `enemy.gd`)

---

### NPCs to Integrate

1. **Knight Character** (Currently Unused)
   - File: `elisa_spritesheet.png`
   - Location: `assets/sprites/characters/player_knight/`
   - Use as: School guard or quest NPC
   - Animations: Idle, walk, attack (already available)

2. **Other NPC Sprites**
   - Location: `assets/sprites/characters/npcs/` (33 PNG files)
   - Use for: Headmaster, Students, Shopkeeper, Librarian
   - Implementation: Create NPC system with dialogue

---

### Environment Props to Integrate

1. **Magical Seal Archway**
   - File: `magical_seal_archway.png`
   - Use for: Boss arena entrances, special puzzle areas, landmarks
   - Implementation: Add as Sprite2D node in special areas

2. **Pillar and Chandelier**
   - File: `pillar_chandelier.png`
   - Use for: Dungeon interior decoration, atmosphere
   - Implementation: Add as Sprite2D nodes in dungeon levels

3. **Waterfall/Orb**
   - File: `waterfall_orb.png`
   - Use for: Animated magical light sources, atmospheric effects
   - Implementation: Create AnimatedSprite2D for pulsing effect

---

### Tilesets to Integrate

1. **Twilight Tileset**
   - File: `twilight_tileset.png`
   - Use for: Dark fantasy dungeons, gothic architecture
   - Features: Dark stone walls, green glowing tiles, banners

2. **Dungeon Tilesets**
   - Files: `dungeon_tileset_01.png`, `dungeon_tileset_02.png`
   - Use for: Castle/dungeon structures
   - Implementation: Create TileSet resource, replace ColorRect walls

3. **Basic Tiles**
   - File: `tiles_001.png` (32x32 pixels)
   - Use for: General level structure
   - Implementation: Create TileSet resource for walls/floors

---

## 📋 Implementation Checklist

### Week 1: Core Loop Completion

- [ ] **Day 1-2: Level Transition System**
  - [ ] Create `level_hub.tscn`
  - [ ] Create `school_hub.tscn`
  - [ ] Create 3-5 biome scenes
  - [ ] Update `GameManager` for scene transitions
  - [ ] Add "Return to School" button
  - [ ] Test: Can travel between areas

- [ ] **Day 3-4: Material Collection System**
  - [ ] Create `MaterialPickup` script
  - [ ] Create material types
  - [ ] Create material inventory UI
  - [ ] Auto-collect monster parts
  - [ ] Connect materials to school upgrades
  - [ ] Test: Can collect and use materials

- [ ] **Day 5: School Hub Scene**
  - [ ] Create school hub scene
  - [ ] Add NPCs (basic setup)
  - [ ] Add dialogue system (simple)
  - [ ] Test: Can walk around school, talk to NPCs

---

### Week 2: Content & Polish

- [ ] **Day 1-2: More Enemies**
  - [ ] Integrate bat enemy
  - [ ] Create bat AI (flying pattern)
  - [ ] Add to dungeon levels
  - [ ] Test: Bat enemy works correctly

- [ ] **Day 3: Tileset Integration**
  - [ ] Create TileSet resources
  - [ ] Replace ColorRect walls with tiles
  - [ ] Add props (pillars, chandeliers)
  - [ ] Test: Levels look professional

- [ ] **Day 4-5: Visual Polish**
  - [ ] Spell casting effects
  - [ ] Material pickup visuals
  - [ ] Movement trail
  - [ ] Door unlock animations
  - [ ] Test: All visual effects work

---

## 🚀 Quick Start: First Implementation

### Step 1: Create Level Hub (30 minutes)

1. Create new scene: `scenes/level_hub.tscn`
2. Add CanvasLayer node
3. Add VBoxContainer with buttons:
   - "Dark Forest" → loads `dark_forest_level.tscn`
   - "Dungeon" → loads `dungeon_level.tscn`
   - "Village" → loads `village_level.tscn`
   - "Return to School" → loads `school_hub.tscn`
4. Create script: `scripts/ui/level_hub_ui.gd`
5. Update `start_menu.gd` to load `level_hub.tscn` instead of `test_level.tscn`

### Step 2: Create School Hub (1 hour)

1. Create new scene: `scenes/school_hub.tscn`
2. Add Room node (like test_level)
3. Set background to `village_004_1920x1080.png`
4. Add "Go Explore" button → loads `level_hub.tscn`
5. Add "Magic School Management" button → opens existing school UI
6. Test: Can navigate between school and level selection

### Step 3: Create First New Biome (1 hour)

1. Duplicate `test_level.tscn` → `dark_forest_level.tscn`
2. Update Room node:
   - Change `room_id` to "dark_forest_01"
   - Change `room_name` to "Dark Forest"
3. Update `room.gd` background loading:
   - Change to `forest_001_1920x1080.png`
4. Add "Return to School" button in UI
5. Test: Can explore Dark Forest and return to school

---

## 💡 Pro Tips

1. **Start Small:** Get one biome working end-to-end before adding more
2. **Reuse Code:** Material system can copy from spell system
3. **Use Available Assets:** Don't create new assets, use what you have
4. **Test Frequently:** Test each feature as you build it
5. **Iterate:** Get basic version working, then polish

---

## 📝 Notes

- All systems are modular - you can work on any part independently
- Save/Load system already handles room state - will work with new biomes
- Quest system already works - will work with new areas
- School management UI already works - just needs materials integration

---

## 🎯 Success Criteria

**After completing these steps, players should be able to:**
1. ✅ Select where to explore from a level hub
2. ✅ Explore different biomes with unique visuals
3. ✅ Collect materials while exploring
4. ✅ Return to a physical school hub
5. ✅ Use materials to upgrade school
6. ✅ See progression unlock new areas

**This completes the core Dave the Diver loop!**
