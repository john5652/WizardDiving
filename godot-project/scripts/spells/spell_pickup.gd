extends Area2D

## Spell Pickup - Collectible spell item in the world

@export var spell_id: String = "fireball"
@export var pickup_id: String = ""  # Unique identifier for saving
@export var auto_collect: bool = false

@onready var sprite: ColorRect = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

var collected: bool = false

func _ready():
	# Generate unique ID if not set
	if pickup_id == "":
		pickup_id = spell_id + "_" + str(get_path())
	
	# Check if this pickup should be removed (from save data)
	if SaveManager and SaveManager.is_pickup_collected(get_room_id(), pickup_id):
		print("Spell pickup ", spell_id, " was already collected, removing...")
		queue_free()
		return
	
	# Set up collision detection
	body_entered.connect(_on_body_entered)
	
	# Visual feedback - make it glow/pulse
	if sprite:
		var tween = create_tween()
		tween.set_loops()
		tween.tween_property(sprite, "modulate", Color(1.5, 1.5, 1.5, 1.0), 0.5)
		tween.tween_property(sprite, "modulate", Color.WHITE, 0.5)
	
	print("Spell pickup created: ", spell_id)

func _on_body_entered(body):
	"""Called when player enters the pickup area"""
	if collected:
		return
	
	if body.is_in_group("player") and body.has_method("collect_spell"):
		collected = true
		
		# Register pickup as collected in save system
		if SaveManager:
			SaveManager.register_pickup_collected(get_room_id(), pickup_id)
		
		var spell_data = SpellManager.get_spell(spell_id)
		if not spell_data.is_empty():
			SpellManager.collect_spell(spell_id)
			body.collect_spell(spell_data)
		collect_effect()
		queue_free()

func get_room_id() -> String:
	"""Get the room ID this pickup belongs to"""
	# Try to find Room node in the scene tree
	var room = get_tree().get_first_node_in_group("room")
	if not room:
		# Fallback: search up the tree for Room node
		var current = get_parent()
		while current:
			if current.name == "Room":
				room = current
				break
			current = current.get_parent()
	
	# Access room_id property if room exists
	if room:
		var room_id = room.get("room_id")
		if room_id is String and room_id != "":
			return room_id
	
	return "unknown_room"

func collect_effect():
	"""Visual/audio effect when collected"""
	# TODO: Add particle effect, sound, etc.
	print("Spell collected: ", spell_id)
