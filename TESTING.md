# Testing Guide - Cross-Platform

## Testing Checklist

### Windows Testing
- [ ] Game launches without errors
- [ ] Player movement works (WASD/Arrow keys)
- [ ] Player can collect spells
- [ ] Doors can be unlocked with correct spells
- [ ] Combat system works
- [ ] UI elements display correctly
- [ ] No performance issues
- [ ] Save/load functionality works

### Mac Testing
- [ ] Game launches without errors
- [ ] Player movement works (WASD/Arrow keys)
- [ ] Player can collect spells
- [ ] Doors can be unlocked with correct spells
- [ ] Combat system works
- [ ] UI elements display correctly
- [ ] No performance issues
- [ ] Save/load functionality works

## Platform-Specific Issues to Watch For

### File Paths
- Use `user://` for save files (Godot handles cross-platform)
- Avoid hardcoded paths
- Test file I/O on both platforms

### Input
- Test both keyboard and gamepad
- Verify key bindings work on both platforms
- Check for platform-specific input quirks

### Performance
- Monitor FPS on both platforms
- Check memory usage
- Test on different hardware configurations

### UI Scaling
- Test at different resolutions
- Verify UI elements scale correctly
- Check font rendering on both platforms

## How to Test

1. **On Windows:**
   ```powershell
   # Open project in Godot
   # Or run from command line if Godot is in PATH
   godot godot-project/project.godot
   ```

2. **On Mac:**
   ```bash
   # Open project in Godot
   open -a Godot godot-project/project.godot
   # Or
   godot godot-project/project.godot
   ```

## Reporting Issues

When reporting platform-specific issues, include:
- Operating system version
- Godot version
- Steps to reproduce
- Expected vs actual behavior
- Screenshots if applicable
