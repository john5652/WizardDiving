# Git Workflow Guide - Cross-Platform Development

This guide will help you work seamlessly between your Windows (office) and Mac (home) machines.

## Initial Setup (One-Time)

### 1. Create GitHub Repository

1. Go to [GitHub](https://github.com) and sign in
2. Click the "+" icon in the top right → "New repository"
3. Name it (e.g., "wizard-diver-game")
4. Choose **Private** (unless you want it public)
5. **DO NOT** initialize with README, .gitignore, or license (we'll add these)
6. Click "Create repository"

### 2. Initial Setup on Windows (Office)

```powershell
# Navigate to your project directory
cd "C:\Users\johna\Desktop\Cursor Projects\First Game"

# Initialize git repository
git init

# Add remote repository (replace with your actual GitHub URL)
git remote add origin https://github.com/YOUR_USERNAME/wizard-diver-game.git

# Add all files
git add .

# Create initial commit
git commit -m "Initial project setup"

# Push to GitHub (you'll be prompted for credentials)
git push -u origin main
```

**Note:** If you haven't set up Git credentials on Windows:
- For HTTPS: GitHub will prompt for username and Personal Access Token (not password)
- Create a token at: https://github.com/settings/tokens
- Or use GitHub Desktop for easier authentication

### 3. Initial Setup on Mac (Home)

```bash
# Navigate to where you want the project
cd ~/Projects  # or wherever you prefer

# Clone the repository
git clone https://github.com/YOUR_USERNAME/wizard-diver-game.git

# Navigate into the project
cd wizard-diver-game
```

## Daily Workflow

### Starting a Work Session

**On Windows:**
```powershell
# Navigate to project
cd "C:\Users\johna\Desktop\Cursor Projects\First Game"

# Pull latest changes from GitHub
git pull origin main

# Open project in Godot (if Godot is in PATH)
# Or open Godot manually and open: godot-project/project.godot
```

**On Mac:**
```bash
# Navigate to project
cd ~/Projects/wizard-diver-game

# Pull latest changes from GitHub
git pull origin main

# Open project in Godot
open -a Godot godot-project/project.godot
# Or: godot godot-project/project.godot (if in PATH)
```

### During Development

1. Make your changes
2. Test in Godot
3. Commit frequently (small, logical commits):

```bash
# Stage your changes
git add .

# Or stage specific files
git add godot-project/scenes/player.tscn
git add godot-project/scripts/player.gd

# Commit with descriptive message
git commit -m "Add player flying movement mechanics"
```

**Good commit messages:**
- ✅ "Add spell collection system"
- ✅ "Fix door unlocking bug in dungeon level"
- ✅ "Update player sprite animation"
- ❌ "fixes"
- ❌ "update"
- ❌ "stuff"

### Ending a Work Session

**Before leaving your machine:**

```bash
# Check what files have changed
git status

# Stage all changes
git add .

# Commit with descriptive message
git commit -m "Description of what you worked on"

# Push to GitHub
git push origin main
```

**Example:**
```bash
git add .
git commit -m "Implement basic spell inventory UI and collection mechanics"
git push origin main
```

## Handling Merge Conflicts

If you forget to pull before starting work, or if both machines have changes:

### Scenario: You have local changes, remote has updates

```bash
# Try to pull
git pull origin main

# If there are conflicts, Git will tell you which files
# Open the conflicted files and look for markers:
# <<<<<<< HEAD
# Your changes
# =======
# Remote changes
# >>>>>>> branch-name

# Edit the file to resolve conflicts, then:
git add <resolved-file>
git commit -m "Resolve merge conflicts"
git push origin main
```

### Best Practice: Always Pull First

```bash
# Always do this at the start of each session
git pull origin main
```

## Branch Strategy (Optional but Recommended)

For larger features, consider using branches:

```bash
# Create a new branch for a feature
git checkout -b feature/spell-system

# Work on your feature, commit as usual
git add .
git commit -m "Work in progress on spell system"

# Push the branch
git push -u origin feature/spell-system

# When feature is complete, merge to main:
git checkout main
git pull origin main
git merge feature/spell-system
git push origin main

# Delete the feature branch (optional)
git branch -d feature/spell-system
git push origin --delete feature/spell-system
```

## Common Issues and Solutions

### Issue: "Your branch is ahead of 'origin/main' by X commits"

**Solution:** You have local commits that haven't been pushed. Just push:
```bash
git push origin main
```

### Issue: "Your branch is behind 'origin/main' by X commits"

**Solution:** You need to pull first:
```bash
git pull origin main
```

### Issue: "Please tell me who you are"

**Solution:** Configure Git (one-time setup):
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Issue: Authentication failed

**Solution:** 
- Use a Personal Access Token instead of password
- Or set up SSH keys (more secure, one-time setup)
- Or use GitHub Desktop for easier authentication

## Quick Reference

| Task | Command |
|------|---------|
| Check status | `git status` |
| See changes | `git diff` |
| Pull latest | `git pull origin main` |
| Stage all | `git add .` |
| Commit | `git commit -m "message"` |
| Push | `git push origin main` |
| View history | `git log --oneline` |
| Undo last commit (keep changes) | `git reset --soft HEAD~1` |
| Discard local changes | `git checkout -- <file>` |

## Workflow Checklist

**Start of Session:**
- [ ] `git pull origin main`
- [ ] Open project in Godot
- [ ] Verify everything works

**During Development:**
- [ ] Test changes in Godot
- [ ] Commit frequently with good messages
- [ ] Don't commit broken code

**End of Session:**
- [ ] `git add .`
- [ ] `git commit -m "descriptive message"`
- [ ] `git push origin main`
- [ ] Verify push succeeded

## Tips

1. **Commit often:** Small, frequent commits are better than large, infrequent ones
2. **Pull before push:** Always pull first to avoid conflicts
3. **Test before commit:** Don't commit broken code
4. **Write good messages:** Future you will thank present you
5. **Use branches for experiments:** Try new features in branches first

## Getting Help

- Git documentation: https://git-scm.com/doc
- GitHub Help: https://help.github.com
- Git cheat sheet: https://education.github.com/git-cheat-sheet-education.pdf
