extends Node2D

## Room/Level Manager - Handles room transitions and Castlevania-style level structure

@export var room_id: String = "room_1"
@export var room_name: String = "Unknown Room"
@export var connected_rooms: Array[String] = []
@export var biome_type: String = "dungeon"  # "dungeon", "forest", "village", "school", "mystical"

var doors: Array = []  # Array of Door nodes
var enemies: Array = []  # Array of Enemy nodes

# Biome-specific background mapping
var biome_backgrounds: Dictionary = {
	"dungeon": "res://assets/sprites/environment/dungeons/fantasy_002_1920x1080.png",
	"forest": "res://assets/sprites/environment/dungeons/forest_001_1920x1080.png",
	"village": "res://assets/sprites/environment/dungeons/village_004_1920x1080.png",
	"school": "res://assets/sprites/environment/dungeons/village_004_1920x1080.png",
	"mystical": "res://assets/sprites/environment/dungeons/fantasy_005_1920x1080.png",
	"test": "res://assets/sprites/environment/dungeons/fantasy_002_1920x1080.png"  # Better background for test level
}

@onready var background: Sprite2D = $Background

func _ready():
	# Add to room group for easy access
	add_to_group("room")
	
	# Find all doors and enemies in this room
	doors = _find_children_of_type("Door")
	enemies = _find_children_of_type("Enemy")
	
	# Load background texture based on biome
	if background:
		var texture_path = biome_backgrounds.get(biome_type, biome_backgrounds["dungeon"])
		if ResourceLoader.exists(texture_path):
			var texture = load(texture_path) as Texture2D
			background.texture = texture
			# Scale background to fill viewport (1280x720)
			if texture:
				var viewport_size = Vector2(1280, 720)
				var texture_size = texture.get_size()
				var scale_x = viewport_size.x / texture_size.x
				var scale_y = viewport_size.y / texture_size.y
				# Use the larger scale to ensure coverage
				var scale_factor = max(scale_x, scale_y)
				background.scale = Vector2(scale_factor, scale_factor)
				background.z_index = -100  # Ensure it's behind everything
				print("Loaded background: ", texture_path, " for biome: ", biome_type)
		else:
			print("Warning: Background texture not found at: ", texture_path)
	
	print("Room initialized: ", room_name, " (", room_id, ") - Biome: ", biome_type)

func _find_children_of_type(type_name: String) -> Array:
	"""Find all children of a specific type"""
	var found = []
	_find_children_recursive(self, type_name, found)
	return found

func _find_children_recursive(node: Node, type_name: String, found: Array):
	"""Recursively find children of a type"""
	for child in node.get_children():
		if child.get_script() and child.get_script().resource_path.ends_with(type_name.to_lower() + ".gd"):
			found.append(child)
		_find_children_recursive(child, type_name, found)

func get_room_data() -> Dictionary:
	"""Get room data for saving/loading"""
	return {
		"id": room_id,
		"name": room_name,
		"connected_rooms": connected_rooms,
		"enemies_defeated": enemies.size() == 0
	}
