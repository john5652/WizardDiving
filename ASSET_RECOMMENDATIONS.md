# Specific Asset Recommendations

This document provides **direct recommendations** for assets to download for your Wizard Diver game, based on real searches and the highest priority needs.

## ⚠️ Important: Don't Worry About Exact Sizes!

**You don't need to stress about finding assets that are exactly 32x32 pixels!**

- Assets between **16x16 and 96x96 pixels** will work fine
- I can resize any asset to match your game
- Focus on finding assets you **like** - size is my problem to solve!

**See `ASSET_SIZE_GUIDE.md` for detailed information about checking sizes and how I'll handle different dimensions.**

---

## 🎯 Priority Assets to Get First

Based on your game's current status, here are the **3 most important assets** to get:

### 1. Player Character (Wizard Sprite) ⭐ HIGHEST PRIORITY

**What you need:** A wizard/witch character sprite (32x32 or 64x64 pixels)

#### Recommended Options:

**Option A: PixelAntasy Character Pack**
- **Website:** OpenGameArt.org
- **Search:** "PixelAntasy" or visit: https://opengameart.org/content/pixelantasy
- **Why:** 7 characters with animations (walk, run, jump, attack)
- **Size:** 64x64 to 96x96 pixels (can be scaled down)
- **License:** Check license on the page (usually CC0 or CC-BY)
- **Best for:** Good quality, multiple animation frames

**Option B: Pixel People (Customizable)**
- **Website:** OpenGameArt.org  
- **Search:** "Pixel People" or visit: https://opengameart.org/content/pixel-people
- **Why:** Over 500 sprites with customizable parts (tops, bottoms, hairstyles)
- **Size:** Various sizes
- **License:** Check license on the page
- **Best for:** Creating a unique wizard by mixing parts

**Option C: 32-pixel Human Sprites (Base)**
- **Website:** LPC (Liberated Pixel Cup) on OpenGameArt
- **Search:** "32-pixel Human Sprites" or visit: https://lpc.opengameart.org/content/32-pixel-human-sprites
- **Why:** 32x32 human sprites with various hairstyles and colors
- **Size:** 32x32 pixels (perfect match!)
- **License:** Usually CC-BY-SA 3.0
- **Best for:** Simple base that you can customize

**What to download:**
- Look for a wizard/mage character OR a human character you can use as a base
- Download the sprite sheet or individual frames
- File format: PNG
- Place in: `godot-project/assets/sprites/characters/player/`

---

### 2. Enemy Sprite (Goblin/Monster) ⭐ HIGH PRIORITY

**What you need:** A goblin or monster enemy sprite (24x32 to 32x32 pixels)

#### Recommended Options:

**Option A: GOBLIN FREE PIXELART (Best Match!)**
- **Website:** OpenGameArt.org
- **Search:** "GOBLIN FREE PIXELART" or visit: https://opengameart.org/content/goblin-free-pixelart
- **Why:** Perfect size (32x32), includes animations (idle, attack, run, death)
- **Size:** 32x32 pixels (perfect!)
- **Animations:** Idle (right, left, front), attack (right and left), run (right and left), death
- **License:** Check license on page (usually CC0)
- **Best for:** Ready-to-use goblin with animations

**Option B: Monsters Slime, Skeleton, and Goblin**
- **Website:** OpenGameArt.org
- **Search:** "Monsters Slime, Skeleton, and Goblin"
- **Why:** 16x16 pixel goblin with animations (idle, run, attack, jump, damage, death)
- **Size:** 16x16 pixels (smaller, but can scale up)
- **License:** Check license on page
- **Best for:** Simple, smaller sprite option

**Option C: Animated Goblins (LPC)**
- **Website:** LPC on OpenGameArt
- **Search:** "Animated Goblins" or visit: https://lpc.opengameart.org/content/animated-goblins
- **Why:** Two goblin variations with animations
- **Size:** Various (check page)
- **License:** Usually CC-BY-SA 3.0
- **Best for:** Multiple enemy variations

**What to download:**
- Download the goblin sprite sheet or individual frames
- File format: PNG
- Place in: `godot-project/assets/sprites/characters/enemies/`

---

### 3. Background/Dungeon Tiles ⭐ HIGH PRIORITY

**What you need:** Dungeon/background tiles or a full background image

#### Recommended Options:

**Option A: Dungeon Crawl 32x32 Tiles (BEST OPTION!)**
- **Website:** OpenGameArt.org
- **Search:** "Dungeon Crawl 32x32 Tiles" or visit: https://opengameart.org/content/dungeon-crawl-32x32-tiles
- **Why:** Huge collection (3,000+ tiles!), perfect size (32x32), includes everything
- **Size:** 32x32 pixels (perfect match!)
- **Includes:** Terrain, walls, decorations, monsters, spell effects, items, GUI elements
- **License:** Usually CC0 (public domain)
- **Best for:** Comprehensive tile set with everything you need

**Option B: Evil Dungeon Asset Pack**
- **Website:** OpenGameArt.org
- **Search:** "Evil Dungeon Asset Pack" or visit: https://opengameart.org/content/evil-dungeon-asset-pack
- **Why:** Complete dungeon tileset with walls, floors, doors, decorations, animated elements
- **Size:** RPG-Maker XP format (can be adapted)
- **License:** Check license on page
- **Best for:** Themed dungeon with animated elements

**Option C: DENZI's 32x32 Orthogonal Tilesets**
- **Website:** OpenGameArt.org
- **Search:** "DENZI's 32x32 Orthogonal Tilesets" or visit: https://opengameart.org/content/denzis-32x32-orthogonal-tilesets
- **Why:** 32x32 pixel art in 3/4 overhead perspective
- **Size:** 32x32 pixels
- **Includes:** Dungeon tiles, monsters, items, ability icons
- **License:** Check license on page
- **Best for:** Consistent style across all assets

**Option D: Simple Dungeon Tileset**
- **Website:** OpenGameArt.org
- **Search:** "Simple Dungeon Tileset" or visit: https://opengameart.org/content/simple-dungeon-tileset
- **Why:** Designed for 2D platformers, multiple scales (16x16, 32x32, 64x64)
- **Size:** 16x16, 32x32, or 64x64 (choose 32x32)
- **Includes:** Floors, walls, blocks, doors, decorations
- **License:** Check license on page
- **Best for:** Simple, clean dungeon style

**What to download:**
- Download the tile set (usually a ZIP file with multiple images)
- Extract to a temporary folder first
- Look for floor tiles, wall tiles, and background elements
- File format: PNG
- Place in: `godot-project/assets/sprites/environment/dungeons/`

---

## 📋 Quick Download Checklist

Use this checklist as you download assets:

### Player Sprite
- [ ] Found a wizard/character sprite on OpenGameArt.org
- [ ] Downloaded as PNG format
- [ ] Size is 32x32 or 64x64 pixels (or close)
- [ ] Has transparent background
- [ ] Saved to: `godot-project/assets/sprites/characters/player/`
- [ ] Named: `player.png` or `player_idle.png`

### Enemy Sprite
- [ ] Found a goblin/monster sprite on OpenGameArt.org
- [ ] Downloaded as PNG format
- [ ] Size is 24x24 to 32x32 pixels
- [ ] Has transparent background
- [ ] Saved to: `godot-project/assets/sprites/characters/enemies/`
- [ ] Named: `enemy_goblin.png` or `enemy.png`

### Background Tiles
- [ ] Found dungeon/background tiles on OpenGameArt.org
- [ ] Downloaded tile set (ZIP file)
- [ ] Extracted ZIP to temporary folder
- [ ] Selected relevant tiles (floors, walls, backgrounds)
- [ ] Files are PNG format
- [ ] Saved to: `godot-project/assets/sprites/environment/dungeons/`
- [ ] Named descriptively: `tile_floor.png`, `tile_wall.png`, etc.

---

## 🔗 Direct Links Summary

Here are direct search links to help you find assets:

### OpenGameArt.org Searches:
1. **Wizard/Character Sprites:**
   - Search: "wizard pixel art character"
   - Search: "pixel art character sprite top down"
   - Search: "fantasy character sprite"

2. **Enemy Sprites:**
   - Search: "goblin pixel art sprite"
   - Search: "monster pixel art enemy"
   - Search: "fantasy enemy sprite"

3. **Dungeon Tiles:**
   - Search: "dungeon tileset 32x32"
   - Search: "dungeon background tiles"
   - Search: "cave tiles pixel art"

### Alternative Sites:
- **Kenney.nl:** https://kenney.nl/assets (search "Fantasy" or "RPG")
- **itch.io:** https://itch.io/game-assets (filter by "free" and "pixel art")
- **Craftpix.net:** https://craftpix.net (has free sections)

---

## 📝 What to Do After Downloading

1. **Extract ZIP files** (if downloaded as ZIP) to a temporary folder
2. **Review the files:**
   - Check dimensions (open in image viewer)
   - Verify PNG format
   - Check for transparent backgrounds (for sprites)
3. **Organize files:**
   - Rename files clearly (e.g., `player.png`, `enemy_goblin.png`)
   - Remove any files you don't need
4. **Place in project folders:**
   - Copy files to the appropriate folders (see folder structure above)
5. **Tell me:**
   - "I've added [asset type] to [folder path]"
   - List the file names you added
   - I'll integrate them into the game!

---

## 🎨 Style Guidelines Reminder

When choosing assets, keep in mind:
- **Art Style:** 2D pixel art (not hand-drawn or 3D)
- **Colors:** Magical blues and purples for player, darker colors for enemies
- **Size:** 32x32 pixels is ideal (can work with 16x16, 64x64, or other sizes)
- **Format:** PNG with transparent background (for sprites)
- **Consistency:** Try to choose assets with similar art styles

---

## ⚡ Quick Start Workflow (30 Minutes)

1. **Open OpenGameArt.org in your browser**
2. **Search for:** "GOBLIN FREE PIXELART" → Download the goblin sprite
3. **Search for:** "Dungeon Crawl 32x32 Tiles" → Download the dungeon tiles
4. **Search for:** "PixelAntasy" → Download a character sprite
5. **Extract ZIP files** to your Downloads folder
6. **Copy files** to your project folders:
   - Goblin → `godot-project/assets/sprites/characters/enemies/`
   - Dungeon tiles → `godot-project/assets/sprites/environment/dungeons/`
   - Character → `godot-project/assets/sprites/characters/player/`
7. **Tell me what you've added**, and I'll integrate them!

---

## 💡 Tips

- **Start small:** Get 1-3 assets first, test them in-game, then add more
- **Check licenses:** Most OpenGameArt assets are free, but check the license (CC0 is best - no restrictions)
- **Don't worry about perfect matches:** Any pixel art is better than colored rectangles!
- **Size flexibility:** If an asset is slightly different size (e.g., 48x48 instead of 32x32), that's fine - I can adjust
- **Sprite sheets are fine:** If you get a sprite sheet with multiple frames, that's great - I can configure animations

---

**Ready to start?** Pick one asset from the recommendations above and download it. Then tell me what you've added, and I'll integrate it into your game!
