extends StaticBody2D

## Door - Can be locked/unlocked with spells

@export var door_id: String = "door_1"
@export var required_spell: String = "unlock_door"
@export var is_locked: bool = true
@export var leads_to_scene: String = ""  # Scene to transition to

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var interaction_area: Area2D = $InteractionArea

var is_open: bool = false

func _ready():
	if interaction_area:
		interaction_area.body_entered.connect(_on_body_entered)
	
	update_door_state()
	print("Door initialized: ", door_id, " (Locked: ", is_locked, ")")

func _on_body_entered(body):
	"""Check if player wants to interact"""
	if body.has_method("check_interactions"):
		# Player is near, can interact
		pass

func interact(player: Node):
	"""Called when player interacts with door"""
	if is_open:
		open_door()
		return
	
	if is_locked:
		# Check if player has required spell
		if player.has_method("has_spell") and player.has_spell(required_spell):
			unlock_door()
		else:
			show_message("This door requires: " + required_spell)
	else:
		open_door()

func unlock_door():
	"""Unlock the door using a spell"""
	is_locked = false
	print("Door unlocked: ", door_id)
	update_door_state()
	# TODO: Add unlock animation/effect

func open_door():
	"""Open the door and transition if needed"""
	is_open = true
	update_door_state()
	
	if leads_to_scene != "":
		GameManager.change_scene(leads_to_scene)
	else:
		print("Door opened: ", door_id)
		# TODO: Add open animation

func update_door_state():
	"""Update visual state of door"""
	if is_open:
		sprite.modulate = Color(0.5, 0.5, 0.5, 1.0)  # Gray when open
		if collision:
			collision.set_deferred("disabled", true)
	elif is_locked:
		sprite.modulate = Color(1.0, 0.3, 0.3, 1.0)  # Red when locked
	else:
		sprite.modulate = Color.WHITE  # White when unlocked but closed

func show_message(text: String):
	"""Show a message to the player"""
	# TODO: Implement UI message system
	print(text)
