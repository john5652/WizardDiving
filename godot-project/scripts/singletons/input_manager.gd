extends Node

## Input Manager - Singleton
## Centralized input handling and remapping

var move_vector: Vector2 = Vector2.ZERO

func _ready():
	print("Input Manager initialized")

func _process(_delta):
	# Update move vector
	move_vector = get_movement_input()

func get_movement_input() -> Vector2:
	"""Get normalized movement input vector"""
	var input_vector = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("move_down"):
		input_vector.y += 1
	if Input.is_action_pressed("move_up"):
		input_vector.y -= 1
	
	return input_vector.normalized()

func is_interact_pressed() -> bool:
	"""Check if interact button is pressed"""
	return Input.is_action_just_pressed("interact")

func get_spell_slot_pressed() -> int:
	"""Get which spell slot was pressed (1-4), returns 0 if none"""
	if Input.is_action_just_pressed("cast_spell_1"):
		return 1
	if Input.is_action_just_pressed("cast_spell_2"):
		return 2
	if Input.is_action_just_pressed("cast_spell_3"):
		return 3
	if Input.is_action_just_pressed("cast_spell_4"):
		return 4
	return 0

func is_switch_spell_pressed() -> bool:
	"""Check if switch spell button is pressed"""
	return Input.is_action_just_pressed("switch_spell")

func is_cast_spell_pressed() -> bool:
	"""Check if cast current spell button is pressed"""
	return Input.is_action_just_pressed("cast_current_spell")

func is_pause_menu_pressed() -> bool:
	"""Check if pause menu button is pressed"""
	return Input.is_action_just_pressed("pause_menu")
