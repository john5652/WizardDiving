extends Area2D

## Material Pickup - Collectible material item in the world
## Similar to SpellPickup but for materials

@export var material_id: String = "herb_common"
@export var quantity: int = 1  # How many materials this pickup gives
@export var pickup_id: String = ""  # Unique identifier for saving
@export var auto_collect: bool = false

@onready var sprite: ColorRect = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

var collected: bool = false

func _ready():
	# Generate unique ID if not set
	if pickup_id == "":
		pickup_id = material_id + "_" + str(get_path())
	
	# Check if this pickup should be removed (from save data)
	if SaveManager and SaveManager.is_pickup_collected(get_room_id(), pickup_id):
		print("Material pickup ", material_id, " was already collected, removing...")
		queue_free()
		return
	
	# Set up collision detection
	body_entered.connect(_on_body_entered)
	
	# Set visual color based on material type
	if sprite and MaterialManager:
		var material_data = MaterialManager.get_material(material_id)
		if not material_data.is_empty():
			var icon_color = material_data.get("icon_color", Color.WHITE)
			sprite.color = icon_color
	
	# Visual feedback - make it glow/pulse
	if sprite:
		var tween = create_tween()
		tween.set_loops()
		tween.tween_property(sprite, "modulate", Color(1.5, 1.5, 1.5, 1.0), 0.5)
		tween.tween_property(sprite, "modulate", Color.WHITE, 0.5)
	
	print("Material pickup created: ", material_id, " x", quantity)

func _on_body_entered(body):
	"""Called when player enters the pickup area"""
	if collected:
		return
	
	if body.is_in_group("player"):
		collected = true
		
		# Register pickup as collected in save system
		if SaveManager:
			SaveManager.register_pickup_collected(get_room_id(), pickup_id)
		
		# Collect material
		if MaterialManager:
			MaterialManager.collect_material(material_id, quantity)
		
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
	print("Material collected: ", material_id, " x", quantity)
