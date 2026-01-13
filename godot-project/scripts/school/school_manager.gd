extends Node

## Magic School Manager - Handles school management mechanics

var school_level: int = 1
var mana_crystals: int = 100  # Currency
var student_satisfaction: float = 0.5  # 0.0 to 1.0
var unlocked_classes: Array[String] = ["basic_magic"]
var school_upgrades: Dictionary = {}

signal resources_changed(mana_crystals: int)
signal school_level_up(new_level: int)
signal class_unlocked(unlocked_class: String)

func _ready():
	print("School Manager initialized")

func teach_class(className: String) -> bool:
	"""Teach a class and earn resources"""
	if not is_class_unlocked(className):
		return false
	
	# Calculate earnings based on class and satisfaction
	var base_earnings = get_class_earnings(className)
	var earnings = int(base_earnings * (1.0 + student_satisfaction))
	
	mana_crystals += earnings
	student_satisfaction = min(1.0, student_satisfaction + 0.05)  # Increase satisfaction
	
	resources_changed.emit(mana_crystals)
	print("Taught class: ", className, " - Earned: ", earnings)
	
	return true

func get_class_earnings(className: String) -> int:
	"""Get base earnings for a class"""
	var earnings_map = {
		"basic_magic": 20,
		"advanced_magic": 50,
		"combat_magic": 75,
		"healing_magic": 60,
		"elemental_magic": 100
	}
	return earnings_map.get(className, 10)

func is_class_unlocked(className: String) -> bool:
	"""Check if a class is unlocked"""
	return className in unlocked_classes

func unlock_class(className: String, cost: int) -> bool:
	"""Unlock a new class"""
	if is_class_unlocked(className):
		return false
	
	if mana_crystals < cost:
		return false
	
	mana_crystals -= cost
	unlocked_classes.append(className)
	class_unlocked.emit(className)
	resources_changed.emit(mana_crystals)
	print("Unlocked class: ", className)
	return true

func upgrade_school(upgrade_name: String, cost: int, required_materials: Dictionary = {}) -> bool:
	"""Upgrade school facilities
	required_materials: Dictionary of material_id -> quantity needed
	"""
	# Check mana crystals
	if mana_crystals < cost:
		return false
	
	# Check materials if MaterialManager exists
	if MaterialManager and not required_materials.is_empty():
		for material_id in required_materials:
			var required_quantity = required_materials[material_id]
			if not MaterialManager.has_material(material_id, required_quantity):
				var material_data = MaterialManager.get_material(material_id)
				var material_name = material_data.get("name", material_id)
				print("Not enough materials! Need ", required_quantity, "x ", material_name)
				return false
	
	# Consume materials
	if MaterialManager and not required_materials.is_empty():
		for material_id in required_materials:
			var quantity = required_materials[material_id]
			MaterialManager.use_material(material_id, quantity)
	
	# Consume mana crystals
	mana_crystals -= cost
	school_upgrades[upgrade_name] = true
	resources_changed.emit(mana_crystals)
	print("Upgraded school: ", upgrade_name)
	return true

func get_upgrade_requirements(upgrade_name: String) -> Dictionary:
	"""Get material requirements for an upgrade"""
	# Define upgrade requirements
	var requirements = {
		"library": {
			"crystal_mana": 10,
			"herb_common": 5
		},
		"workshop": {
			"crystal_mana": 15,
			"monster_part_goblin": 3
		},
		"herb_garden": {
			"herb_common": 10,
			"crystal_mana": 5
		},
		"observation_tower": {
			"crystal_rare": 5,
			"rune_ancient": 1,
			"crystal_mana": 20
		}
	}
	return requirements.get(upgrade_name, {})

func level_up_school():
	"""Level up the school"""
	school_level += 1
	school_level_up.emit(school_level)
	print("School leveled up to: ", school_level)
