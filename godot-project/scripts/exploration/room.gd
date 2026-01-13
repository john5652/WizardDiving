extends Node2D

## Room/Level Manager - Handles room transitions and Castlevania-style level structure

@export var room_id: String = "room_1"
@export var room_name: String = "Unknown Room"
@export var connected_rooms: Array[String] = []

var doors: Array = []  # Array of Door nodes
var enemies: Array = []  # Array of Enemy nodes

func _ready():
	# Find all doors and enemies in this room
	doors = _find_children_of_type("Door")
	enemies = _find_children_of_type("Enemy")
	
	print("Room initialized: ", room_name, " (", room_id, ")")

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
