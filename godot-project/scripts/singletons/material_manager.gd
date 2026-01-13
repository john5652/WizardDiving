extends Node

## Material Manager - Handles material collection and inventory
## Similar to SpellManager but for collectible materials

var all_materials: Dictionary = {}  # Dictionary of all available material types
var player_materials: Dictionary = {}  # Materials the player has collected (material_id -> quantity)

signal material_collected(material_id: String, quantity: int)
signal materials_changed

func _ready():
	initialize_materials()
	print("Material Manager initialized")

func initialize_materials():
	"""Initialize default material types"""
	# Herbs - for potions and basic upgrades
	register_material({
		"id": "herb_common",
		"name": "Common Herb",
		"type": "herb",
		"rarity": "common",
		"description": "A common herb found in forests",
		"icon_color": Color(0.2, 0.8, 0.3, 1)  # Green
	})
	
	register_material({
		"id": "herb_rare",
		"name": "Rare Herb",
		"type": "herb",
		"rarity": "rare",
		"description": "A rare herb with magical properties",
		"icon_color": Color(0.3, 0.9, 0.4, 1)  # Bright green
	})
	
	# Crystals - for mana and upgrades
	register_material({
		"id": "crystal_mana",
		"name": "Mana Crystal",
		"type": "crystal",
		"rarity": "common",
		"description": "A crystal infused with mana energy",
		"icon_color": Color(0.3, 0.5, 1.0, 1)  # Blue
	})
	
	register_material({
		"id": "crystal_rare",
		"name": "Rare Crystal",
		"type": "crystal",
		"rarity": "rare",
		"description": "A rare crystal with powerful magic",
		"icon_color": Color(0.8, 0.3, 1.0, 1)  # Purple
	})
	
	# Monster Parts - auto-collected from defeated enemies
	register_material({
		"id": "monster_part_goblin",
		"name": "Goblin Claw",
		"type": "monster_part",
		"rarity": "common",
		"description": "A claw from a defeated goblin",
		"icon_color": Color(0.6, 0.4, 0.2, 1)  # Brown
	})
	
	register_material({
		"id": "monster_part_bat",
		"name": "Bat Wing",
		"type": "monster_part",
		"rarity": "common",
		"description": "A wing from a defeated bat",
		"icon_color": Color(0.3, 0.3, 0.3, 1)  # Dark gray
	})
	
	# Ancient Runes - rare, for special upgrades
	register_material({
		"id": "rune_ancient",
		"name": "Ancient Rune",
		"type": "rune",
		"rarity": "rare",
		"description": "An ancient rune with mysterious power",
		"icon_color": Color(1.0, 0.8, 0.2, 1)  # Gold
	})

func register_material(material_data: Dictionary):
	"""Register a material type in the material database"""
	var material_id = material_data.get("id", "")
	if material_id != "":
		all_materials[material_id] = material_data

func collect_material(material_id: String, quantity: int = 1) -> bool:
	"""Collect materials and add to player inventory"""
	if not all_materials.has(material_id):
		push_error("Material not found: " + material_id)
		return false
	
	# Initialize if not in inventory
	if not player_materials.has(material_id):
		player_materials[material_id] = 0
	
	player_materials[material_id] += quantity
	material_collected.emit(material_id, quantity)
	materials_changed.emit()
	
	var material_data = all_materials[material_id]
	print("Collected ", quantity, "x ", material_data.get("name"))
	return true

func get_material_quantity(material_id: String) -> int:
	"""Get quantity of a material the player has"""
	return player_materials.get(material_id, 0)

func has_material(material_id: String, required_quantity: int = 1) -> bool:
	"""Check if player has enough of a material"""
	return get_material_quantity(material_id) >= required_quantity

func use_material(material_id: String, quantity: int = 1) -> bool:
	"""Use/consume materials"""
	if not has_material(material_id, quantity):
		return false
	
	player_materials[material_id] -= quantity
	if player_materials[material_id] <= 0:
		player_materials.erase(material_id)
	
	materials_changed.emit()
	print("Used ", quantity, "x ", all_materials.get(material_id, {}).get("name", material_id))
	return true

func get_material(material_id: String) -> Dictionary:
	"""Get material data by ID"""
	if all_materials.has(material_id):
		return all_materials[material_id]
	return {}

func get_all_player_materials() -> Dictionary:
	"""Get all materials player has collected"""
	return player_materials.duplicate()

func get_materials_by_type(type: String) -> Dictionary:
	"""Get all materials of a specific type"""
	var filtered = {}
	for material_id in player_materials:
		var material_data = all_materials.get(material_id, {})
		if material_data.get("type") == type:
			filtered[material_id] = player_materials[material_id]
	return filtered
