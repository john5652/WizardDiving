extends StaticBody2D

## Door - Can be locked/unlocked with spells

@export var door_id: String = "door_1"
@export var required_spell: String = "unlock_door"
@export var is_locked: bool = true
@export var leads_to_scene: String = ""  # Scene to transition to
@export var interaction_range: float = 60.0  # How close player needs to be

@onready var visual: ColorRect = $Visual
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var interaction_area: Area2D = $InteractionArea

var is_open: bool = false
var player: Node2D = null
var player_nearby: bool = false

func _ready():
	# Add to interactable group
	add_to_group("interactable")
	
	# Check if this door should be unlocked (from save data)
	if SaveManager and SaveManager.is_door_unlocked(get_room_id(), door_id):
		print("Door ", door_id, " was unlocked, restoring state...")
		is_locked = false
		update_door_state()
	
	if interaction_area:
		interaction_area.body_entered.connect(_on_body_entered)
		interaction_area.body_exited.connect(_on_body_exited)
		# Make sure it can detect bodies
		interaction_area.monitoring = true
		interaction_area.monitorable = false
	
	# Find player
	find_player()
	
	update_door_state()
	print("Door initialized: ", door_id, " (Locked: ", is_locked, ", Required spell: ", required_spell, ")")

func get_room_id() -> String:
	"""Get the room ID this door belongs to"""
	var room = get_tree().get_first_node_in_group("room")
	if not room:
		var current = get_parent()
		while current:
			if current.name == "Room":
				room = current
				break
			current = current.get_parent()
	
	if room:
		var room_id = room.get("room_id")
		if room_id is String and room_id != "":
			return room_id
	
	return "unknown_room"

func _process(_delta):
	# Check if player is nearby
	if player:
		var distance = global_position.distance_to(player.global_position)
		player_nearby = distance <= interaction_range
		
		# Check if player pressed E and is nearby
		if Input.is_action_just_pressed("interact") and player_nearby:
			interact(player)
		
		# Visual feedback - pulse when player is nearby
		if player_nearby and visual:
			var pulse = sin(Time.get_ticks_msec() / 200.0) * 0.1 + 1.0
			visual.modulate = Color(pulse, pulse, pulse, 1.0)
		elif visual:
			visual.modulate = Color.WHITE

func find_player():
	"""Find the player in the scene"""
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]

func _on_body_entered(body):
	"""Player entered interaction area"""
	if body.is_in_group("player"):
		player = body
		print("Player near door: ", door_id)

func _on_body_exited(body):
	"""Player left interaction area"""
	if body.is_in_group("player"):
		# Keep reference but note they're not in range
		pass

func interact(player: Node):
	"""Called when player interacts with door"""
	print("=== DOOR INTERACTION ===")
	print("Door: ", door_id)
	print("Locked: ", is_locked)
	print("Required spell: ", required_spell)
	
	if is_open:
		print("Door is already open!")
		open_door()
		return
	
	if is_locked:
		# Check player's collected spells directly (primary check)
		var has_spell = false
		if player and player.has_method("has_collected_spell"):
			has_spell = player.has_collected_spell(required_spell)
			print("Player has spell '", required_spell, "': ", has_spell, " (from player.collected_spells)")
		
		# Fallback: also check SpellManager
		if not has_spell:
			has_spell = SpellManager.has_spell(required_spell)
			print("Player has spell '", required_spell, "': ", has_spell, " (from SpellManager)")
		
		if has_spell:
			print("✓ Unlocking door!")
			unlock_door()
			show_message("Door unlocked!")
		else:
			print("✗ Player does NOT have required spell!")
			show_message("This door requires the spell: " + required_spell + "\nCollect it first!")
			if player:
				print("Player collected spells: ", player.collected_spells)
			print("Available spells in SpellManager: ", SpellManager.player_spells)
	else:
		print("Door is unlocked, opening...")
		open_door()

func unlock_door():
	"""Unlock the door using a spell"""
	is_locked = false
	
	# Register door as unlocked in save system
	if SaveManager:
		SaveManager.register_door_unlocked(get_room_id(), door_id)
	
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
	if not visual:
		return
		
	if is_open:
		visual.color = Color(0.5, 0.5, 0.5, 1.0)  # Gray when open
		if collision:
			collision.set_deferred("disabled", true)
	elif is_locked:
		visual.color = Color(1.0, 0.3, 0.3, 1.0)  # Red when locked
	else:
		visual.color = Color(0.6, 0.6, 0.8, 1.0)  # Light blue when unlocked but closed

func show_message(text: String):
	"""Show a message to the player"""
	# TODO: Implement UI message system
	print(text)
