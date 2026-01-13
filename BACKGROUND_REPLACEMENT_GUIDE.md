# Background Replacement Guide

## Quick Answer: Can You Drag & Drop Images?

**YES!** You can drag and drop images directly into this chat, and I'll integrate them into your game.

---

## How to Replace the Background

### Method 1: Single Static Background (Easiest)

**Step 1:** Prepare your image
- Format: PNG or JPG
- Size: Any (I'll scale it to fit)
- Recommended: 1920x1080 or 1280x720 (16:9 aspect ratio)

**Step 2:** Drag and drop the image into this chat

**Step 3:** Tell me:
> "Use this as the background for the test level"
> OR
> "Use this as the background for [biome name]"

**Step 4:** I'll handle:
- ✅ Saving it to the correct assets folder
- ✅ Updating the room script to load it
- ✅ Configuring proper scaling
- ✅ Testing that it displays correctly

---

### Method 2: Animated Background

**What I need:**
- Multiple image files (frames of animation)
- OR a sprite sheet with multiple frames

**Step 1:** Prepare your frames
- Format: PNG files
- Naming: `bg_frame_01.png`, `bg_frame_02.png`, etc. (or any clear naming)
- OR: One sprite sheet with frames arranged in a grid

**Step 2:** Drag and drop all files (or ZIP them first)

**Step 3:** Tell me:
> "Turn these into an animated background at 2 FPS"
> OR
> "Create a looping animated background from these frames"

**Step 4:** I'll:
- ✅ Create an AnimatedSprite2D node
- ✅ Set up all animation frames
- ✅ Configure animation speed
- ✅ Make it loop seamlessly
- ✅ Position it as the background

---

### Method 3: Multiple Backgrounds (Different Biomes)

**Step 1:** Prepare your images
- Name them clearly: `dark_forest_bg.png`, `dungeon_bg.png`, etc.
- OR put them in a ZIP file

**Step 2:** Drag and drop (or ZIP)

**Step 3:** Tell me:
> "Use these as backgrounds for different biomes"
> OR
> "Set up these backgrounds: dark_forest_bg.png for Dark Forest, dungeon_bg.png for Dungeon"

**Step 4:** I'll:
- ✅ Organize them in the assets folder
- ✅ Set up the room system to load different backgrounds per biome
- ✅ Configure each one properly

---

## Current Background Setup

**Location:** `godot-project/scripts/exploration/room.gd`  
**Current Background:** `fantasy_001_1920x1080.png`  
**How it works:** Background loads automatically when a room/level starts

**To change it manually (if you prefer):**
1. Place your image in: `godot-project/assets/sprites/environment/dungeons/`
2. Update line 21 in `room.gd`:
   ```gdscript
   var texture_path = "res://assets/sprites/environment/dungeons/YOUR_IMAGE.png"
   ```

---

## Image Requirements

### Static Backgrounds
- **Format:** PNG (transparent) or JPG (opaque)
- **Size:** Any (I'll scale to fit 1280x720 viewport)
- **Aspect Ratio:** 16:9 recommended (1920x1080, 1280x720)
- **File Size:** Under 5MB recommended
- **Style:** Should match game's fantasy/pixel art aesthetic

### Animated Backgrounds
- **Format:** PNG (transparent background recommended)
- **Frame Count:** 2-12 frames (more = smoother but larger file)
- **Animation Speed:** 1-4 FPS (slow, atmospheric)
- **Loop:** Should loop seamlessly (first frame = last frame)
- **Naming:** Clear, sequential names help

---

## Examples

### Example 1: Simple Background Replacement
```
You: [Drags forest_background.png]
You: "Use this as the background"
Me: ✅ Done! Background updated.
```

### Example 2: Animated Background
```
You: [Drags bg_01.png, bg_02.png, bg_03.png, bg_04.png]
You: "Make these into an animated background at 2 FPS"
Me: ✅ Done! Animated background created with 4 frames looping at 2 FPS.
```

### Example 3: Multiple Biomes
```
You: [Drags ZIP with forest_bg.png, dungeon_bg.png, school_bg.png]
You: "Set up these backgrounds for different biomes"
Me: ✅ Done! Each biome now has its own background.
```

---

## Tips

1. **Darker backgrounds work better** - They don't compete with gameplay elements
2. **Consistent art style** - Keep backgrounds matching the game's aesthetic
3. **Parallax layers** - Can be added later (foreground/midground/background)
4. **Performance** - Large images are fine, I'll optimize them

---

## Troubleshooting

**If background doesn't show:**
- Check file path in `room.gd`
- Verify image is in correct assets folder
- Check image format (PNG/JPG)

**If background is too small/large:**
- I'll adjust scaling automatically
- Can manually tweak in `room.gd` if needed

**If animated background doesn't loop:**
- Check frame count
- Verify all frames are same size
- Animation speed might need adjustment

---

## Ready to Replace?

Just drag and drop your image(s) and tell me what you want! 🎨
