extends CharacterBody2D

## Player Character - Wizard with flying movement
## Handles movement, spell casting, and player state

@export var speed: float = 200.0
@export var acceleration: float = 1000.0
@export var friction: float = 800.0
@export var max_health: int = 100
@export var current_health: int = 100

@onready var visual: ColorRect = $Visual
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var spell_cast_point: Node2D = $SpellCastPoint

var collected_spells: Array[Dictionary] = []
var equipped_spells: Array = []  # 4 spell slots (can contain Dictionary or null)
var current_spell_slot: int = 0  # Currently selected spell slot (0-3)
var spell_cooldowns: Dictionary = {}  # Track cooldowns per spell
var last_cast_time: float = 0.0
var cast_cooldown: float = 0.3  # Minimum time between casts

signal spell_collected(spell_data: Dictionary)
signal health_changed(new_health: int, max_health: int)
signal player_died
signal spell_cast(spell_name: String)
signal current_spell_changed(slot: int)

func _ready():
	current_health = max_health
	health_changed.emit(current_health, max_health)
	add_to_group("player")
	# Initialize equipped_spells with 4 null slots
	equipped_spells.resize(4)
	print("Player initialized")
	print("Controls: WASD to move, TAB to switch spells, SPACE to cast")

func _physics_process(delta):
	handle_movement(delta)
	handle_input()
	update_cooldowns(delta)
	
	# Update TAB cooldown
	if tab_cooldown > 0:
		tab_cooldown -= delta

func handle_movement(delta):
	"""Handle player movement with smooth acceleration"""
	var input_vector = InputManager.get_movement_input()
	
	if input_vector.length() > 0:
		# Accelerate towards input direction
		velocity = velocity.move_toward(input_vector * speed, acceleration * delta)
		
		# Flip visual based on direction
		if input_vector.x != 0 and visual:
			visual.scale.x = sign(input_vector.x)
	else:
		# Apply friction when no input
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	# Use move_and_slide with exclusion for enemies (so they don't block)
	move_and_slide()
	
	# Push enemies away if stuck
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider and collider.is_in_group("enemies"):
			# Push enemy away slightly
			var push_force = (collider.global_position - global_position).normalized() * 50
			if collider.has_method("apply_knockback"):
				collider.apply_knockback(push_force)

var tab_cooldown: float = 0.0
var tab_cooldown_time: float = 0.2
var last_tab_state: bool = false

func handle_input():
	"""Handle player input for spells and interactions"""
	# Check for spell switching (TAB) - detect key press
	var tab_pressed = Input.is_key_pressed(KEY_TAB) or Input.is_action_pressed("switch_spell")
	var tab_just_pressed = Input.is_action_just_pressed("switch_spell")
	
	# Detect TAB key just pressed (edge detection)
	if tab_pressed and not last_tab_state and tab_cooldown <= 0:
		switch_to_next_spell()
		tab_cooldown = tab_cooldown_time
	
	last_tab_state = tab_pressed
	
	# Check for casting current spell (SPACE)
	if InputManager.is_cast_spell_pressed():
		cast_spell(current_spell_slot)
	
	# Legacy: Still support 1-4 keys for direct casting (also switches to that slot)
	var spell_slot = InputManager.get_spell_slot_pressed()
	if spell_slot > 0 and spell_slot <= equipped_spells.size():
		current_spell_slot = spell_slot - 1
		cast_spell(current_spell_slot)
		current_spell_changed.emit(current_spell_slot)
	
	# Check for interactions (E key for doors)
	if InputManager.is_interact_pressed():
		check_interactions()

func cast_spell(slot_index: int):
	"""Cast spell from specified slot"""
	if slot_index < 0 or slot_index >= equipped_spells.size():
		print("Invalid slot: ", slot_index + 1)
		return
	
	var spell = equipped_spells[slot_index]
	if spell == null or not spell is Dictionary:
		print("No spell in slot ", slot_index + 1, " - Collect spells first!")
		return
	
	# Check cooldown
	var current_time = Time.get_ticks_msec() / 1000.0
	if current_time - last_cast_time < cast_cooldown:
		return
	
	var spell_id = spell.get("id", "")
	if spell_id != "" and spell_cooldowns.has(spell_id):
		var cooldown_end = spell_cooldowns[spell_id]
		if current_time < cooldown_end:
			return
	
	var spell_name = spell.get("name", "Unknown")
	print("Casting spell: ", spell_name, " from slot ", slot_index + 1)
	
	# Create spell projectile
	if ResourceLoader.exists("res://scenes/spell_projectile.tscn"):
		var projectile_scene = load("res://scenes/spell_projectile.tscn")
		var projectile = projectile_scene.instantiate()
		
		# Add to Room node, not root
		var room = get_tree().get_first_node_in_group("room")
		if not room:
			room = get_tree().current_scene.get_node_or_null("Room")
		if room:
			room.add_child(projectile)
		else:
			get_tree().current_scene.add_child(projectile)
		
		projectile.position = get_global_spell_cast_position()
		
		# Get cast direction - prefer movement direction, then mouse, then forward
		var cast_direction = Vector2.RIGHT
		var input_vector = InputManager.get_movement_input()
		if input_vector.length() > 0.1:
			# Cast in movement direction
			cast_direction = input_vector.normalized()
		else:
			# Try mouse position
			var mouse_pos = get_global_mouse_position()
			var mouse_dir = (mouse_pos - global_position).normalized()
			if mouse_dir.length() > 0.1:
				cast_direction = mouse_dir
			else:
				# Default to facing direction
				cast_direction = Vector2.RIGHT if visual and visual.scale.x > 0 else Vector2.LEFT
		
		projectile.direction = cast_direction
		projectile.damage = spell.get("damage", 10)
		projectile.spell_type = spell.get("id", "fireball")
		
		# Set cooldown
		last_cast_time = current_time
		var spell_cooldown = spell.get("cooldown", 1.0)
		spell_cooldowns[spell_id] = current_time + spell_cooldown
		
		spell_cast.emit(spell_name)
	else:
		print("Spell projectile scene not found!")

func update_cooldowns(delta):
	"""Update spell cooldowns (cleanup old ones)"""
	pass  # Cooldowns are time-based, handled in cast_spell

func check_interactions():
	"""Check for interactable objects nearby"""
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = collision_shape.shape
	query.transform = global_transform
	query.collision_mask = 2  # Interactable layer
	
	var results = space_state.intersect_shape(query, 1)
	for result in results:
		var collider = result.collider
		if collider.has_method("interact"):
			collider.interact(self)
			break

func collect_spell(spell_data: Dictionary):
	"""Collect a spell and add to inventory"""
	if spell_data.is_empty():
		print("ERROR: Empty spell data!")
		return
	
	collected_spells.append(spell_data)
	spell_collected.emit(spell_data)
	var spell_name = spell_data.get("name", "Unknown")
	print("✓ Collected spell: ", spell_name)
	
	# Auto-equip to first empty slot if available
	var equipped = false
	for i in range(equipped_spells.size()):
		if equipped_spells[i] == null:
			equip_spell(spell_data, i)
			equipped = true
			print("✓ Equipped to slot ", i + 1, " - Press ", i + 1, " to cast!")
			break
	
	if not equipped:
		print("WARNING: All spell slots full!")

func equip_spell(spell_data: Dictionary, slot: int):
	"""Equip a spell to a specific slot (0-3)"""
	if slot >= 0 and slot < equipped_spells.size():
		equipped_spells[slot] = spell_data
		# Auto-select first equipped spell
		if current_spell_slot >= equipped_spells.size() or equipped_spells[current_spell_slot] == null:
			current_spell_slot = slot
		print("Equipped spell to slot ", slot + 1, ": ", spell_data.get("name", "Unknown"))

func switch_to_next_spell():
	"""Switch to the next available spell"""
	if equipped_spells.is_empty():
		print("No spells equipped!")
		return
	
	# Count how many spells we have
	var available_spells = []
	for i in range(equipped_spells.size()):
		if equipped_spells[i] != null and equipped_spells[i] is Dictionary:
			available_spells.append(i)
	
	if available_spells.is_empty():
		print("No spells available!")
		return
	
	if available_spells.size() == 1:
		# Only one spell, just select it
		current_spell_slot = available_spells[0]
		var spell_name = equipped_spells[current_spell_slot].get("name", "Unknown")
		print("Selected spell: ", spell_name, " (Slot ", current_spell_slot + 1, ")")
		current_spell_changed.emit(current_spell_slot)
		return
	
	# Find current position in available spells
	var current_index = -1
	for i in range(available_spells.size()):
		if available_spells[i] == current_spell_slot:
			current_index = i
			break
	
	# Move to next spell (wrap around)
	if current_index >= 0:
		var next_index = (current_index + 1) % available_spells.size()
		current_spell_slot = available_spells[next_index]
	else:
		# Current slot is invalid, select first available
		current_spell_slot = available_spells[0]
	
	var spell_name = equipped_spells[current_spell_slot].get("name", "Unknown")
	print("Switched to spell: ", spell_name, " (Slot ", current_spell_slot + 1, ")")
	current_spell_changed.emit(current_spell_slot)

func take_damage(amount: int):
	"""Take damage and check for death"""
	current_health -= amount
	current_health = max(0, current_health)
	health_changed.emit(current_health, max_health)
	
	if current_health <= 0:
		die()

func heal(amount: int):
	"""Heal the player"""
	current_health += amount
	current_health = min(max_health, current_health)
	health_changed.emit(current_health, max_health)

func die():
	"""Handle player death"""
	player_died.emit()
	print("Player died!")
	# TODO: Implement death/respawn logic

func get_global_spell_cast_position() -> Vector2:
	"""Get the global position where spells should be cast from"""
	if spell_cast_point:
		return spell_cast_point.global_position
	return global_position
