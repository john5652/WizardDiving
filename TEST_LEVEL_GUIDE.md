# Test Level Guide 🎮

## What You'll See

When you run the game (F5), you'll experience a **fully playable test level** with:

### 🎯 Features

1. **Player Character**
   - Blue glowing square (your wizard)
   - Smooth flying movement
   - Camera follows you

2. **Spell Pickups** (3 total)
   - 🔥 **Fireball** (red/orange) - Combat spell
   - ❄️ **Ice Shard** (blue/cyan) - Combat spell  
   - 🔓 **Unlock Door** (yellow) - Utility spell

3. **Locked Door**
   - Red door on the right side
   - Requires "Unlock Door" spell
   - Press **Space** near it to interact

4. **Enemy**
   - Green Goblin that chases you
   - Has health bar above it
   - Deals damage on contact
   - Can be damaged with spells

5. **UI Elements**
   - Health bar (top-left)
   - Spell inventory (top-right) - Shows equipped spells
   - Instructions (bottom-center)

6. **Environment**
   - Dark blue/purple background
   - Brown walls on all sides (you can't fly through them)
   - Level boundaries

## Controls

- **WASD** or **Arrow Keys** - Move/Fly
- **Space** - Interact (collect spells, open doors)
- **1-4** - Cast equipped spells (aims toward mouse cursor)

## Gameplay Flow

1. **Start** - You spawn on the left side
2. **Collect Spells** - Fly to the glowing orbs to collect them
   - They automatically equip to empty slots
   - Watch the spell inventory (top-right) update
3. **Fight the Goblin** - Use spells (1-4 keys) to damage it
   - Spells fire toward your mouse cursor
   - The goblin will chase you
4. **Unlock the Door** - Collect the "Unlock Door" spell first
   - Fly to the red door on the right
   - Press **Space** to interact
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

- **Spell Casting**: Move your mouse cursor to aim spells
- **Combat**: Keep moving to avoid the goblin
- **Collection**: Spells auto-equip to the first available slot
- **Interactions**: Get close to objects and press Space

## Next Steps After Testing

Once you've tested everything:
1. Create more levels with different layouts
2. Add more enemy types
3. Create the magic school scene
4. Add more spells and abilities
5. Design better visuals (replace placeholders)

Enjoy testing your game! 🎉
