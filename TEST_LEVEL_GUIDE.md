# Test Level Guide 🎮

## What You'll See

When you run the game (F5), you'll experience a **fully playable test level** with:

### 🎯 Features

1. **Player Character**
   - Animated wizard sprite with walk/run/idle animations
   - Smooth flying movement
   - Camera follows you
   - Sprite scales appropriately (2.0x) and flips based on movement direction

2. **Spell Pickups** (3 total)
   - 🔥 **Fireball** (red/orange) - Combat spell
   - ❄️ **Ice Shard** (blue/cyan) - Combat spell  
   - 🔓 **Unlock Door** (yellow) - Utility spell

3. **Locked Door**
   - Red door on the right side
   - Requires "Unlock Door" spell
   - Press **Space** near it to interact

4. **Enemy**
   - Animated goblin sprite with walk/idle animations
   - Has health bar above it
   - Deals damage on contact
   - Can be damaged with spells
   - Sprite scales appropriately (1.8x) and flips based on movement direction

5. **UI Elements**
   - Health bar (top-left)
   - Spell inventory (top-right) - Shows equipped spells
   - Instructions (bottom-center)

6. **Environment**
   - Fantasy background texture (pixel art environment)
   - Brown walls on all sides (you can't fly through them)
   - Level boundaries

## Controls

- **WASD** or **Arrow Keys** - Move/Fly
- **TAB** - Switch between equipped spells
- **1-4** - Cast spell from that slot (also switches to that slot)
- **SPACE** - Cast currently selected spell (fires in movement direction)
- **E** - Interact with doors/objects
- **ESC** - Open/Close pause menu

## Gameplay Flow

1. **Start** - You spawn on the left side
2. **Collect Spells** - Fly to the glowing orbs to collect them
   - They automatically equip to empty slots
   - Watch the spell inventory (top-right) update
3. **Fight the Goblin** - Use spells (1-4 keys or SPACE) to damage it
   - Spells fire in your movement direction (move toward the goblin while casting)
   - The goblin will chase you and deal damage on contact
   - Watch the goblin's health bar above it
4. **Unlock the Door** - Collect the "Unlock Door" spell first
   - Fly to the red door on the right
   - Press **E** to interact (not Space!)
   - Door will unlock and turn gray
5. **Explore** - The level is fully interactive!

## What to Test

✅ **Movement** - Smooth flying in all directions  
✅ **Spell Collection** - Pickups disappear and appear in inventory  
✅ **Spell Casting** - Press 1-4 to fire spells toward mouse  
✅ **Combat** - Damage the goblin with spells  
✅ **Door Unlocking** - Collect unlock spell, then interact with door  
✅ **Collision** - Walls prevent you from leaving the level  
✅ **Camera** - Follows player smoothly  

## Tips

- **Spell Casting**: Spells fire in your movement direction - move toward enemies while casting
- **Spell Switching**: Use TAB to cycle through your equipped spells
- **Combat**: Keep moving to avoid the goblin's contact damage
- **Collection**: Spells auto-equip to the first available slot (watch the top-right UI)
- **Interactions**: Get close to doors and press E (not Space!)
- **Pause**: Press ESC anytime to pause and access menu options

## Next Steps After Testing

Once you've tested everything:
1. Create more levels with different layouts
2. Add more enemy types
3. Improve spell pickup visuals (replace colored rectangles)
4. Add spell casting visual effects (particles, trails)
5. Add more spells and abilities
6. Add save/load system

Enjoy testing your game! 🎉
