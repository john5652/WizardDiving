# Asset Integration Plan - Following Recommendations

## Summary

Based on my recommendations, I'll integrate the following assets:

1. ✅ **Player:** Wizard sprite (PixelAntasy - `wizard_1.png`)
2. ✅ **Enemy:** PixelAntasy goblin (for consistency - `goblin_2.png`)  
3. ✅ **Background:** Fantasy background (`fantasy_001_1920x1080.png`)
4. ✅ **Projectiles:** Fireball/iceball sprites

## Integration Steps Required

### 1. Player Character Integration
**Files to modify:**
- `godot-project/scenes/test_level.tscn` - Replace ColorRect with Sprite2D
- `godot-project/scripts/player/player.gd` - Update visual node type (ColorRect → Sprite2D)

**Changes:**
- Replace `[node name="Visual" type="ColorRect"]` with `[node name="Visual" type="Sprite2D"]`
- Set texture to `res://assets/sprites/characters/player/Wizard 1/PNG/wizard_1.png`
- Remove PlayerGlow ColorRect (or keep for effects)
- Update script to handle Sprite2D instead of ColorRect for scaling/flipping
- Scale sprite to match game size (wizard is 64-96px, need to scale to ~32-64px)

### 2. Enemy Character Integration  
**Files to modify:**
- `godot-project/scenes/test_level.tscn` - Replace enemy ColorRect with Sprite2D
- `godot-project/scripts/enemies/enemy.gd` - Update visual node type

**Changes:**
- Replace `[node name="Visual" type="ColorRect"]` with `[node name="Visual" type="Sprite2D"]`
- Set texture to PixelAntasy goblin (`goblin_2.png`)
- Scale appropriately
- Update script references

### 3. Background Integration
**Files to modify:**
- `godot-project/scenes/test_level.tscn` - Replace ColorRect background with TextureRect or Sprite2D

**Changes:**
- Replace `[node name="Background" type="ColorRect"]` with `[node name="Background" type="TextureRect"]` or use Sprite2D
- Set texture to `res://assets/sprites/environment/dungeons/fantasy_001_1920x1080.png`
- Configure to fill screen properly

### 4. Spell Projectile Integration
**Files to modify:**
- `godot-project/scenes/spell_projectile.tscn` - Replace ColorRect with Sprite2D
- `godot-project/scripts/spells/spell_projectile.gd` - Update to use sprite textures

**Changes:**
- Replace `[node name="Visual" type="ColorRect"]` with `[node name="Visual" type="Sprite2D"]`
- Update script to set texture based on spell_type (fireball → fireball sprite, ice_shard → iceball sprite)

## Important Notes

- **Script Changes Required:** The player and enemy scripts currently reference `@onready var visual: ColorRect`. This needs to change to `@onready var visual: Sprite2D` and update any code that modifies `visual.color` (should use `visual.modulate` instead for Sprite2D).

- **Scaling:** Wizard and goblin sprites are 64-96px, but game expects 32px. We'll need to scale them (either in Godot import settings or via scale property).

- **Animations:** For now, we'll use static sprites (single frame). Animations can be added later.

---

**Ready to proceed?** This will modify multiple files. Should I continue with the full integration?
