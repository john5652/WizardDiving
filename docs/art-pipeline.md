# Art Pipeline Documentation

## Art Style Guidelines

### Target Style
- **2D pixel art** or **hand-drawn 2D** style
- Colorful, magical aesthetic
- Consistent with fantasy/magical theme
- Readable at various zoom levels

### Color Palette
- **Primary:** Magical blues and purples
- **Secondary:** Warm oranges and yellows (for contrast)
- **Accent:** Bright whites and golds (for magic effects)
- **Environment:** Varies by biome (cities = bright, dungeons = dark)

## Asset Organization

```
godot-project/assets/
├── sprites/
│   ├── characters/
│   │   ├── player/
│   │   ├── npcs/
│   │   └── enemies/
│   ├── environment/
│   │   ├── cities/
│   │   ├── castles/
│   │   └── dungeons/
│   ├── ui/
│   └── items/
├── animations/
│   ├── player/
│   ├── enemies/
│   └── effects/
├── audio/
│   ├── music/
│   └── sfx/
└── fonts/
```

## Sprite Specifications

### Player Character
- **Size:** 32x32 or 64x64 pixels (base)
- **Animations Needed:**
  - Idle (floating)
  - Flying (forward, up, down, diagonal)
  - Spell casting (multiple directions)
  - Collection animation
  - Damage/hurt

### Environment Tiles
- **Tile Size:** 16x16 or 32x32 pixels
- **Layers:** Background, midground, foreground
- **Parallax:** Support for depth

### UI Elements
- **Icons:** 16x16 or 32x32 pixels
- **Buttons:** Scalable 9-slice sprites
- **Panels:** Reusable UI panels

## Animation Workflow

### Using Godot's Animation System

1. **Sprite Sheets:**
   - Create sprite sheets with all frames
   - Import into Godot
   - Use AnimatedSprite2D or AnimationPlayer

2. **Frame-by-Frame:**
   - Individual sprite files per frame
   - Organized in folders by animation name
   - Godot will auto-detect sequences

3. **AnimationPlayer:**
   - For complex animations
   - Property animations
   - Signal-based triggers

## Asset Sources

### Free Resources
- **OpenGameArt.org:** Free, open-source game art
- **itch.io:** Free and paid asset packs
- **Kenney.nl:** Free game assets
- **Craftpix.net:** Free and premium assets

### AI-Generated Assets
- **Tools:** DALL-E, Midjourney, Stable Diffusion
- **Workflow:**
  1. Generate concept art
  2. Use as reference
  3. Create pixel art version manually
  4. Or use AI pixel art generators

### Commissioned Art
- **Platforms:** Fiverr, Upwork, ArtStation
- **Budget:** Plan for $50-$200 per character/set
- **Specifications:** Provide this document as reference

## Import Process

### Step 1: Prepare Assets
- Export in PNG format (transparent background)
- Use consistent naming: `character_action_frame01.png`
- Organize in folders before importing

### Step 2: Import to Godot
1. Place files in appropriate `assets/` folder
2. Godot will auto-import
3. Check import settings:
   - **Filter:** Enabled (for pixel art, may disable)
   - **Mipmaps:** Disabled for pixel art
   - **Compress:** Based on file size

### Step 3: Configure Sprites
1. Create Sprite2D or AnimatedSprite2D node
2. Assign texture
3. Set up animations if needed
4. Configure collision shapes

### Step 4: Test in Scene
- Verify appearance
- Check performance
- Test animations
- Verify scaling

## Placeholder Art Strategy

### Phase 1: Development (Weeks 1-8)
- Use simple colored rectangles
- Basic shapes for characters
- Minimal detail
- Focus on gameplay

### Phase 2: Art Integration (Weeks 9-12)
- Replace placeholders systematically
- Start with player character
- Then environments
- Finally UI polish

### Placeholder Guidelines
- Use distinct colors for different elements
- Add simple text labels if needed
- Make them recognizable (red = enemy, blue = player)
- Keep same dimensions as final art

## Animation Guidelines

### Frame Rates
- **Idle animations:** 2-4 FPS (slow, subtle)
- **Movement:** 8-12 FPS (smooth)
- **Combat:** 12-16 FPS (fast, impactful)
- **Effects:** 16-24 FPS (fluid)

### Animation Principles
- **Squash and Stretch:** For impact
- **Anticipation:** Before actions
- **Follow-through:** After actions
- **Easing:** Smooth start/end

## Audio Integration

### Music
- **Format:** OGG Vorbis (Godot's preferred)
- **Loops:** Seamless looping tracks
- **Layers:** Dynamic music system (optional)

### Sound Effects
- **Format:** WAV or OGG
- **Categories:**
  - UI sounds (clicks, hovers)
  - Spell casting
  - Collection sounds
  - Ambient environment
  - Combat sounds

## Performance Considerations

### Optimization
- **Sprite Atlases:** Combine small sprites
- **Texture Compression:** Balance quality/size
- **Animation Caching:** Preload common animations
- **LOD:** Lower detail for distant objects

### File Sizes
- **Target:** Keep individual sprites < 100KB
- **Total Assets:** Aim for < 50MB for MVP
- **Compression:** Use Godot's built-in compression

## Tools Recommended

### Pixel Art
- **Aseprite:** Professional pixel art tool ($20)
- **Piskel:** Free online pixel editor
- **GIMP:** Free, powerful image editor
- **Photoshop:** Industry standard (paid)

### Animation
- **Aseprite:** Built-in animation support
- **DragonBones:** Free 2D animation
- **Spine:** Professional 2D animation (paid)

## Checklist for New Assets

- [ ] Asset matches art style guide
- [ ] Proper dimensions and format
- [ ] Named consistently
- [ ] Placed in correct folder
- [ ] Imported correctly in Godot
- [ ] Tested in-game
- [ ] Performance acceptable
- [ ] Documented if needed

## Version Control for Art

### Best Practices
- **Binary Files:** Git LFS for large files (optional)
- **Source Files:** Keep .psd/.ase files separate (not in repo)
- **Exports Only:** Commit only final PNG exports
- **Changelog:** Document major art updates

### File Naming Convention
```
category_name_variant_frame.ext

Examples:
- character_player_idle_01.png
- environment_castle_wall_01.png
- ui_button_hover.png
- spell_fireball_cast_03.png
```
