# Asset Integration Guide - Step by Step

This guide walks you through **exactly how to get backgrounds and assets** for your Wizard Diver game and prepare them for integration.

---

## 📋 Overview

Your game currently uses **placeholder graphics** (colored rectangles). To polish the visuals, you need:
- **Player sprite** (wizard/witch character)
- **Enemy sprites** (goblins, monsters)
- **Backgrounds** (level environments)
- **Spell effects** (visual effects for casting)
- **UI elements** (optional polish)

---

## Step 1: Choose Your Asset Source

You have **three main options** for getting assets:

### Option A: Free Asset Packs (Recommended for Quick Start) ⭐

**Best for:** Getting assets quickly and testing the game visually

**Recommended Sites:**
1. **OpenGameArt.org** - https://opengameart.org
   - Completely free, open-source art
   - Search for: "wizard", "goblin", "fantasy", "2D pixel art"
   - License: Usually CC0 or CC-BY (very permissive)

2. **Kenney.nl** - https://kenney.nl/assets
   - Professional quality free assets
   - Has pixel art packs
   - Search for: "Fantasy", "RPG", "Characters"

3. **itch.io Asset Packs** - https://itch.io/game-assets
   - Mix of free and paid
   - Great pixel art collections
   - Many free packs available

4. **Craftpix.net** - https://craftpix.net
   - Has free sections
   - Good fantasy assets
   - Search for "pixel art"

**What to Download:**
- Look for: "2D pixel art character sprites"
- Look for: "Fantasy game assets"
- Look for: "Top-down or side-view characters"
- Priority: Player sprite, enemy sprites, background tiles

**Time Required:** 15-30 minutes to browse and download

---

### Option B: AI-Generated Assets

**Best for:** Custom-looking assets if you want something unique

**Tools:**
1. **DALL-E / ChatGPT Image Generation**
   - Prompt: "2D pixel art wizard character sprite, 32x32 pixels, fantasy style, blue robes, magical"
   - Prompt: "2D pixel art background tiles, dungeon environment, 32x32 pixel tiles, dark fantasy"

2. **Stable Diffusion** (free, but more technical)
   - Use pixel art models
   - Generate then manually touch up

3. **Pixel Art AI Generators**
   - Search for "pixel art generator AI"
   - Some online tools available

**Limitations:**
- AI art often needs manual cleanup
- May not match exact dimensions needed
- Licensing can be unclear (check terms)

**Time Required:** 1-2 hours (including cleanup)

---

### Option C: Commissioned Art (Paid)

**Best for:** Professional, custom assets matching your exact vision

**Platforms:**
- **Fiverr** - https://fiverr.com (search "pixel art game sprite")
- **Upwork** - https://upwork.com
- **ArtStation** - https://artstation.com

**Budget Estimate:**
- Single character sprite: $20-$100
- Sprite sheet with animations: $50-$200
- Background tile set: $30-$150
- Full character set: $100-$500

**What to Tell the Artist:**
- Provide the `docs/art-pipeline.md` file as reference
- Specify: 32x32 or 64x64 pixel size
- Request: PNG format, transparent background
- Style: 2D pixel art, magical/fantasy theme

**Time Required:** 1-2 weeks (artist turnaround time)

---

## Step 2: Asset Specifications You Need

Based on your game's requirements:

### Player Character
- **Size:** 32x32 or 64x64 pixels
- **Format:** PNG (transparent background)
- **Style:** Wizard/witch flying character
- **Colors:** Magical blues and purples (see art-pipeline.md)
- **Required animations (optional but recommended):**
  - Idle (floating)
  - Flying in 4-8 directions
  - Spell casting pose

### Enemy Sprites
- **Size:** 24x24 to 32x32 pixels
- **Format:** PNG (transparent background)
- **Style:** Fantasy monsters (goblins, imps, etc.)
- **Quantity needed:** 1-2 types to start

### Backgrounds/Environment
- **Tile Size:** 16x16 or 32x32 pixels (for tile-based backgrounds)
- **Full Background:** 1280x720 or larger (for single image backgrounds)
- **Format:** PNG or JPG
- **Style:** Dark dungeons, magical caves, or fantasy environments
- **Layers:** Can be single image or tile set

### Spell Effects (Optional)
- **Size:** Varies (16x16 to 64x64)
- **Format:** PNG (transparent background)
- **Style:** Magical glows, particles, orbs
- **Colors:** Bright whites, golds, blues

---

## Step 3: Organize Your Assets Before Giving Them to Me

Once you've downloaded/generated your assets, organize them like this:

### Create These Folders (if they don't exist):

```
godot-project/assets/
├── sprites/
│   ├── characters/
│   │   ├── player/          ← Put player sprites here
│   │   └── enemies/         ← Put enemy sprites here
│   ├── environment/         ← Put backgrounds/tiles here
│   └── items/               ← Put spell pickups/items here
└── audio/                   ← For future sound files
```

### File Naming:
Use clear, descriptive names:
- `player_idle.png`
- `player_flying.png`
- `enemy_goblin.png`
- `background_dungeon.png`
- `spell_pickup_orb.png`

---

## Step 4: Prepare Your Assets

### For Sprites (Player, Enemies, Items):

1. **Ensure PNG format** with transparent background
2. **Check dimensions:**
   - Player: 32x32 or 64x64 pixels
   - Enemies: 24x24 to 32x32 pixels
   - Items: 16x16 to 32x32 pixels
3. **If your asset is a sprite sheet:**
   - You can keep it as-is (I'll help extract frames)
   - Or separate into individual PNG files per frame
4. **If dimensions don't match:**
   - Use an image editor (GIMP, Photoshop, Paint.NET) to resize
   - Maintain aspect ratio
   - Use nearest-neighbor scaling for pixel art (preserves sharp edges)

### For Backgrounds:

1. **Tile-based backgrounds:**
   - Individual tile images (16x16 or 32x32)
   - Organized in a folder
   - Named clearly (e.g., `tile_wall.png`, `tile_floor.png`)

2. **Full image backgrounds:**
   - Single large image (1280x720 or larger)
   - Can be JPG or PNG
   - Named descriptively (e.g., `background_cave.png`)

---

## Step 5: How to Give Assets to Me

### Method 1: Place Files in Project (Recommended)

1. **Navigate to your project folder:**
   ```
   c:\Users\johna\Desktop\Cursor Projects\First Game\godot-project\assets\
   ```

2. **Create the folder structure** (if needed):
   - `assets/sprites/characters/player/`
   - `assets/sprites/characters/enemies/`
   - `assets/sprites/environment/`

3. **Copy your asset files** into the appropriate folders

4. **Tell me:**
   - "I've added player sprites to `assets/sprites/characters/player/`"
   - "I've added backgrounds to `assets/sprites/environment/`"
   - List the file names you added

5. **I'll then:**
   - Import them into Godot
   - Update the player/enemy/background code to use them
   - Configure import settings
   - Test in-game

### Method 2: Describe What You Have

If you have assets but aren't sure where to put them:

1. **Tell me:**
   - "I downloaded a pixel art wizard sprite pack"
   - "I have backgrounds from OpenGameArt"
   - "I generated some assets with AI"

2. **Provide details:**
   - File names
   - Where they currently are (downloads folder, etc.)
   - What they are (player, enemy, background)

3. **I'll guide you:**
   - Where to place them
   - How to prepare them
   - What to name them

---

## Step 6: What I'll Do After You Provide Assets

Once you've placed assets in the project and told me about them, I will:

1. ✅ **Check the files** you've added
2. ✅ **Create missing folders** if needed
3. ✅ **Update import settings** in Godot (filter, compression, etc.)
4. ✅ **Replace placeholder graphics** with your assets:
   - Player sprite (currently blue rectangle)
   - Enemy sprites (currently green rectangles)
   - Backgrounds (currently solid color)
   - Spell pickups (currently rectangles)
5. ✅ **Configure animations** (if you have sprite sheets)
6. ✅ **Test in-game** to ensure everything looks correct
7. ✅ **Adjust scaling/positioning** if needed
8. ✅ **Update documentation** to reflect the new assets

---

## Quick Start: Recommended First Assets

To get started quickly, I recommend getting these **3 assets first**:

### Priority 1: Player Sprite
- **Where to find:** OpenGameArt.org → Search "wizard pixel art character"
- **What you need:** One sprite of a wizard/witch character
- **Size:** 32x32 or 64x64 pixels
- **File name:** `player.png` or `player_idle.png`

### Priority 2: Enemy Sprite
- **Where to find:** OpenGameArt.org → Search "goblin pixel art sprite"
- **What you need:** One sprite of a fantasy enemy
- **Size:** 24x24 to 32x32 pixels
- **File name:** `enemy_goblin.png` or `enemy.png`

### Priority 3: Background Image or Tiles
- **Where to find:** OpenGameArt.org → Search "dungeon background" or "cave tiles"
- **What you need:** Either a full background image OR a tile set
- **Size:** Full image (1280x720+) OR tiles (16x16 or 32x32)
- **File name:** `background_dungeon.png` or `tile_*.png`

**Estimated time to find these:** 20-30 minutes on OpenGameArt.org

---

## Troubleshooting

### "My assets don't match the dimensions exactly"
- **Solution:** That's okay! I can resize them or adjust the code. Just provide them as-is.

### "I have a sprite sheet, not individual frames"
- **Solution:** No problem! Godot can use sprite sheets. Just provide the sheet, and I'll configure it.

### "I don't know if my assets are the right style"
- **Solution:** Send them anyway! I can integrate them, and we can refine the style later. Any pixel art is better than colored rectangles.

### "I found assets but they're in a different format (GIF, JPG, etc.)"
- **Solution:** 
  - Convert to PNG using an image editor (GIMP, Paint.NET, or online converter)
  - For sprites: Ensure transparent background (PNG required)
  - For backgrounds: PNG or JPG both work

### "The assets have multiple characters/enemies in one file"
- **Solution:** That's fine! I can either:
  - Use the sprite sheet as-is and configure regions in Godot
  - Help you extract individual sprites (if you want)

---

## Example Workflow (Step-by-Step)

Here's a complete example of getting and integrating a player sprite:

1. **Go to OpenGameArt.org**
2. **Search:** "wizard pixel art character top down"
3. **Download:** A sprite pack (e.g., "Fantasy Character Pack")
4. **Extract:** The ZIP file to your Downloads folder
5. **Find:** The wizard/player character sprite (look for `player.png`, `wizard.png`, or similar)
6. **Check:** Is it PNG? Is it 32x32 or 64x64? (Open in image viewer to check)
7. **Copy:** The file to `godot-project/assets/sprites/characters/player/player.png`
8. **Tell me:** "I've added a player sprite at `assets/sprites/characters/player/player.png`"
9. **I'll integrate it:** I'll update the player code, configure Godot, and test it
10. **Result:** Your game now has a wizard sprite instead of a blue rectangle! 🎉

---

## Next Steps

1. **Choose your asset source** (free assets recommended to start)
2. **Download 1-3 assets** (player, enemy, background)
3. **Place them in the project folders** (see Step 3)
4. **Tell me what you've added**
5. **I'll integrate them into the game**

**Questions?** Just ask! I can help with:
- Finding specific types of assets
- Preparing/resizing assets
- Organizing files
- Converting formats
- Understanding what you need

---

## Summary Checklist

- [ ] Choose asset source (free/purchased/AI/commissioned)
- [ ] Download/obtain assets (player, enemies, backgrounds)
- [ ] Ensure PNG format (transparent for sprites)
- [ ] Check dimensions (32x32 for player, etc.)
- [ ] Create folder structure in `godot-project/assets/`
- [ ] Place assets in correct folders
- [ ] Tell me what assets you've added
- [ ] I'll integrate them and test in-game

**Ready to start?** Begin with Step 1 and get your first asset pack!
