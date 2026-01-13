extends CharacterBody2D

## Player Character - Wizard with flying movement
## Handles movement, spell casting, and player state

@export var speed: float = 200.0
@export var acceleration: float = 1000.0
@export var friction: float = 800.0
@export var max_health: int = 100
@export var current_health: int = 100

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var spell_cast_point: Node2D = $SpellCastPoint

var collected_spells: Array[Dictionary] = []
var equipped_spells: Array[Dictionary] = [null, null, null, null]  # 4 spell slots

signal spell_collected(spell_data: Dictionary)
signal health_changed(new_health: int, max_health: int)
signal player_died

func _ready():
	current_health = max_health
	health_changed.emit(current_health, max_health)
	add_to_group("player")
	print("Player initialized")

func _physics_process(delta):
	handle_movement(delta)
	handle_input()

func handle_movement(delta):
	"""Handle player movement with smooth acceleration"""
	var input_vector = InputManager.get_movement_input()
	
	if input_vector.length() > 0:
		# Accelerate towards input direction
		velocity = velocity.move_toward(input_vector * speed, acceleration * delta)
		
		# Flip sprite based on direction
		if input_vector.x != 0:
			sprite.scale.x = sign(input_vector.x)
	else:
		# Apply friction when no input
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move_and_slide()

func handle_input():
	"""Handle player input for spells and interactions"""
	# Check for spell casting
	var spell_slot = InputManager.get_spell_slot_pressed()
	if spell_slot > 0 and spell_slot <= equipped_spells.size():
		cast_spell(spell_slot - 1)
	
	# Check for interactions
	if InputManager.is_interact_pressed():
		check_interactions()

func cast_spell(slot_index: int):
	"""Cast spell from specified slot"""
	if slot_index < 0 or slot_index >= equipped_spells.size():
		return
	
	var spell = equipped_spells[slot_index]
	if spell == null:
		return
	
	print("Casting spell: ", spell.get("name", "Unknown"))
	# TODO: Implement spell casting logic
	# This will be expanded when spell system is implemented

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
		return
	
	collected_spells.append(spell_data)
	spell_collected.emit(spell_data)
	print("Collected spell: ", spell_data.get("name", "Unknown"))
	
	# Auto-equip to first empty slot if available
	for i in range(equipped_spells.size()):
		if equipped_spells[i] == null:
			equip_spell(spell_data, i)
			break

func equip_spell(spell_data: Dictionary, slot: int):
	"""Equip a spell to a specific slot (0-3)"""
	if slot >= 0 and slot < equipped_spells.size():
		equipped_spells[slot] = spell_data
		print("Equipped spell to slot ", slot + 1, ": ", spell_data.get("name", "Unknown"))

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
