# Quick Implementation Guide
## Top 3 Critical Fixes - Step by Step

---

## Fix #1: Add Crystal Count Display (30-45 min)

### Step 1: Create Resource HUD Script

Create: `godot-project/scripts/ui/resource_hud.gd`

```gdscript
extends Control
## Resource HUD - Displays mana crystals and other resources during exploration

@onready var crystal_label: Label = $CrystalLabel

func _ready():
	if not SchoolManager:
		push_error("SchoolManager not found!")
		return
	
	# Connect to school manager signals
	SchoolManager.resources_changed.connect(_on_resources_changed)
	
	# Initial update
	update_display()

func _on_resources_changed(_mana_crystals: int):
	"""Update display when resources change"""
	update_display()

func update_display():
	"""Update the crystal count display"""
	if SchoolManager:
		crystal_label.text = "💎 " + str(SchoolManager.mana_crystals)
```

### Step 2: Add to Each Exploration Scene

**For each exploration scene** (`test_level.tscn`, `dark_forest_level.tscn`, `dungeon_level.tscn`):

1. Add a `CanvasLayer` node (if not exists) as child of root
2. Add a `Control` node as child of CanvasLayer
3. Name it "ResourceHUD"
4. Set anchors: Top-Left (0, 0)
5. Set position: `(10, 10)` or `(10, 60)` (below health bar)
6. Set size: `(200, 30)`
7. Attach script: `res://scripts/ui/resource_hud.gd`
8. Add `Label` node as child
9. Name it "CrystalLabel"
10. Set text: "💎 100"
11. Set font size: 20-24
12. Set position: `(0, 0)`

### Testing:
- Run game, go to exploration area
- Should see crystal count in top-left
- Change crystals (teach class, spend) - should update immediately

---

## Fix #2: Display Material Inventory During Exploration (1 hour)

### Step 1: Check Material Inventory UI

The UI script exists: `scripts/ui/material_inventory_ui.gd`

It needs these child nodes:
- `Label` (title, can be hidden)
- `VBoxContainer` named "MaterialsList"

### Step 2: Add to Each Exploration Scene

**Option A: Always Visible (Simpler)**

For each exploration scene:

1. In the CanvasLayer (same as ResourceHUD), add `VBoxContainer` node
2. Name it "MaterialInventoryDisplay"
3. Set anchors: Bottom-Left (0, 1)
4. Set position: `(10, -200)` (10px from left, 200px from bottom)
5. Set size: `(250, 150)` or larger
6. Attach script: `res://scripts/ui/material_inventory_ui.gd`
7. Add child `Label` node (name: "Label")
   - Text: "Materials" (or hide it)
   - Set visible = false if you don't want title
8. Add child `VBoxContainer` node (name: "MaterialsList")
   - This will be populated automatically by the script

**Option B: Toggleable (Press I to show/hide)**

1. Follow Option A steps
2. Modify `material_inventory_ui.gd`:
   ```gdscript
   func _ready():
       visible = false  # Start hidden
       # ... rest of _ready code ...
   
   func _input(event):
       if event.is_action_pressed("ui_inventory"):  # Need to add this action
           visible = not visible
   ```
3. Add "ui_inventory" action to Input Map (I key)

### Step 3: Make It Compact (Optional)

Modify `material_inventory_ui.gd` update_display() to only show top 5-6 materials:

```gdscript
func update_display():
    # ... existing code ...
    
    # Sort by quantity (most common first)
    var sorted_materials = []
    for material_id in player_materials:
        sorted_materials.append({
            "id": material_id,
            "quantity": player_materials[material_id]
        })
    sorted_materials.sort_custom(func(a, b): return a.quantity > b.quantity)
    
    # Only show top 6
    var display_count = min(6, sorted_materials.size())
    for i in range(display_count):
        var material_id = sorted_materials[i].id
        var quantity = sorted_materials[i].quantity
        # ... create label for this material ...
```

### Testing:
- Run game, collect materials
- Should see materials list in corner
- Collect more materials - list should update

---

## Fix #3: Complete Death/Respawn System (2-3 hours)

### Step 1: Create Death Screen Scene

Create: `godot-project/scenes/death_screen.tscn`

Scene structure:
```
DeathScreen (Control)
├── Background (ColorRect) - Full screen, semi-transparent black
├── VBoxContainer (centered)
    ├── Title (Label) - "You Died!"
    ├── Message (Label) - "Return to school or try again?"
    ├── HBoxContainer
    │   ├── RetryButton (Button) - "Retry"
    │   └── ReturnButton (Button) - "Return to School"
```

### Step 2: Create Death Screen Script

Create: `godot-project/scripts/ui/death_screen.gd`

```gdscript
extends Control
## Death Screen - Handles player death and respawn options

@onready var retry_button: Button = $VBoxContainer/Buttons/RetryButton
@onready var return_button: Button = $VBoxContainer/Buttons/ReturnButton

var death_position: Vector2
var current_scene_path: String

func _ready():
	# Hide by default
	visible = false
	
	# Connect buttons
	retry_button.pressed.connect(_on_retry_pressed)
	return_button.pressed.connect(_on_return_pressed)

func show_death_screen():
	"""Show the death screen"""
	visible = true
	get_tree().paused = true  # Pause game
	
	# Store current scene info for respawn
	current_scene_path = get_tree().current_scene.scene_file_path

func _on_retry_pressed():
	"""Retry current level"""
	get_tree().paused = false
	visible = false
	
	# Reload current scene
	if current_scene_path:
		GameManager.change_scene(current_scene_path)

func _on_return_pressed():
	"""Return to school hub"""
	get_tree().paused = false
	visible = false
	
	# Go to school hub
	GameManager.change_scene("res://scenes/school_hub.tscn")
```

### Step 3: Update Player Script

Modify: `godot-project/scripts/player/player.gd`

Find the `die()` function and update it:

```gdscript
func die():
	"""Handle player death"""
	player_died.emit()
	print("Player died!")
	
	# Find death screen in scene tree
	var death_screen = get_tree().get_first_node_in_group("death_screen")
	if death_screen and death_screen.has_method("show_death_screen"):
		death_screen.show_death_screen()
	else:
		# Fallback: just reload scene after delay
		await get_tree().create_timer(2.0).timeout
		GameManager.change_scene(get_tree().current_scene.scene_file_path)
```

### Step 4: Add Death Screen to Exploration Scenes

For each exploration scene:

1. Add `DeathScreen` instance as child of root (or CanvasLayer)
2. Set it to full screen (anchors: all corners)
3. Add to group "death_screen"
4. Make sure it's added AFTER the player node in tree (so it's on top)

**Alternative:** Add DeathScreen to a persistent autoload that can be accessed from anywhere.

### Step 5: Handle Player Health Reset on Respawn

Update player script to reset health on scene change:

```gdscript
func _ready():
	current_health = max_health
	health_changed.emit(current_health, max_health)
	# ... rest of _ready ...
```

Or better, reset in the death screen retry function.

### Testing:
- Run game, take damage until you die
- Death screen should appear
- "Retry" should reload current scene
- "Return to School" should go to school hub
- Player health should be reset on retry

---

## Fix #4: Add Basic NPC System (4-5 hours)

### Step 1: Create NPC Base Class

Create: `godot-project/scripts/npcs/npc.gd`

```gdscript
extends CharacterBody2D
## Base NPC Class - Handles interaction and dialogue

@export var npc_name: String = "NPC"
@export var npc_id: String = ""
@export var dialogue_id: String = ""  # ID for dialogue data

@onready var visual: AnimatedSprite2D = $Visual
@onready var interaction_area: Area2D = $InteractionArea

var player: Node2D = null
var can_interact: bool = false

signal npc_interacted(npc: CharacterBody2D)

func _ready():
	add_to_group("npcs")
	
	# Set up interaction area
	if interaction_area:
		interaction_area.body_entered.connect(_on_player_entered)
		interaction_area.body_exited.connect(_on_player_exited)

func _input(event):
	if event.is_action_pressed("ui_interact") and can_interact:
		interact()

func _on_player_entered(body):
	if body.is_in_group("player"):
		player = body
		can_interact = true
		# Show interaction prompt
		show_interaction_prompt()

func _on_player_exited(body):
	if body.is_in_group("player"):
		player = null
		can_interact = false
		hide_interaction_prompt()

func interact():
	"""Called when player presses E near NPC"""
	npc_interacted.emit(self)
	
	# Show dialogue
	if DialogueSystem:
		DialogueSystem.start_dialogue(dialogue_id, npc_name)

func show_interaction_prompt():
	"""Show 'Press E to interact' prompt"""
	# TODO: Add label or visual indicator

func hide_interaction_prompt():
	"""Hide interaction prompt"""
	# TODO: Hide label or visual indicator
```

### Step 2: Create Simple Dialogue System

Create: `godot-project/scripts/npcs/dialogue_system.gd`

```gdscript
extends Node
## Simple Dialogue System - Handles NPC conversations

signal dialogue_started(npc_name: String)
signal dialogue_ended

var dialogue_ui: Control = null

func _ready():
	print("Dialogue System initialized")

func start_dialogue(dialogue_id: String, npc_name: String):
	"""Start a dialogue with an NPC"""
	# Find or create dialogue UI
	if not dialogue_ui:
		dialogue_ui = get_tree().get_first_node_in_group("dialogue_ui")
	
	if not dialogue_ui:
		push_error("Dialogue UI not found!")
		return
	
	# Get dialogue data
	var dialogue_text = get_dialogue_text(dialogue_id)
	
	# Show dialogue UI
	if dialogue_ui.has_method("show_dialogue"):
		dialogue_ui.show_dialogue(npc_name, dialogue_text)
	
	dialogue_started.emit(npc_name)

func get_dialogue_text(dialogue_id: String) -> String:
	"""Get dialogue text by ID"""
	# Simple dialogue database
	var dialogues = {
		"headmaster_greeting": "Welcome, young wizard. The school needs your help!",
		"headmaster_quest": "I have a task for you. Explore the Dark Forest and collect 10 mana crystals.",
		"student_greeting": "Hi! Have you found any cool spells yet?",
		"shopkeeper_greeting": "Looking to trade? I buy monster parts and sell materials.",
	}
	
	return dialogues.get(dialogue_id, "Hello, traveler.")
```

### Step 3: Create Dialogue UI

Create: `godot-project/scenes/dialogue_box.tscn`

Scene structure:
```
DialogueBox (Control) - Full screen, transparent background
└── DialogPanel (Panel)
    ├── NPCNameLabel (Label)
    ├── DialogueTextLabel (Label)
    └── ContinueButton (Button) - "Continue"
```

Create: `godot-project/scripts/ui/dialogue_ui.gd`

```gdscript
extends Control
## Dialogue UI - Displays NPC conversations

@onready var npc_name_label: Label = $DialogPanel/NPCNameLabel
@onready var dialogue_text_label: Label = $DialogPanel/DialogueTextLabel
@onready var continue_button: Button = $DialogPanel/ContinueButton

func _ready():
	add_to_group("dialogue_ui")
	visible = false
	
	continue_button.pressed.connect(_on_continue_pressed)

func show_dialogue(npc_name: String, dialogue_text: String):
	"""Show dialogue box with text"""
	npc_name_label.text = npc_name
	dialogue_text_label.text = dialogue_text
	visible = true
	get_tree().paused = true

func _on_continue_pressed():
	"""Close dialogue box"""
	visible = false
	get_tree().paused = false
	
	if DialogueSystem:
		DialogueSystem.dialogue_ended.emit()
```

### Step 4: Add NPCs to School Hub

In `school_hub.tscn`:

1. Add NPC nodes using available sprites
2. Add `NPC` script to each
3. Set npc_name, npc_id, dialogue_id
4. Position NPCs around the school

Example NPCs:
- Headmaster (center, near entrance)
- Student (near school building)
- Shopkeeper (near side, market area)

### Step 5: Add Dialogue Box to Scenes

Add DialogueBox instance to school_hub.tscn (and other scenes with NPCs)

### Testing:
- Run game, go to school hub
- Walk near NPC
- Press E to interact
- Dialogue box should appear
- Press Continue to close

---

## Quick Testing Checklist

After implementing each fix:

**Fix #1 (Crystal Display):**
- [ ] Crystal count visible during exploration
- [ ] Count updates when crystals change
- [ ] Visible on all exploration scenes

**Fix #2 (Material Inventory):**
- [ ] Material inventory visible during exploration
- [ ] Materials update when collected
- [ ] Can see what materials you have

**Fix #3 (Death/Respawn):**
- [ ] Death screen appears when player dies
- [ ] Retry button works (reloads scene)
- [ ] Return to School button works
- [ ] Player health resets on retry

**Fix #4 (NPCs):**
- [ ] NPCs visible in school hub
- [ ] Can interact with NPCs (Press E)
- [ ] Dialogue box appears
- [ ] Can close dialogue box

---

## Notes

- **Test Each Fix Individually:** Don't implement all at once. Do one, test, then move to next.
- **Reuse Existing Systems:** Material system exists - just needs UI display!
- **Keep It Simple:** These are minimal viable implementations. You can polish later.
- **Check Existing Code:** Some of these systems might be partially implemented. Check before duplicating!

---

**Estimated Total Time: 8-10 hours for all 4 fixes**

**Impact: Transforms game from technical demo to playable game with personality!** ✨
