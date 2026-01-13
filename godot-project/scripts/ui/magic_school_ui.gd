extends Control

## Magic School UI - Manages the magic school interface

@onready var mana_crystals_label: Label = $VBoxContainer/Header/ManaCrystalsLabel
@onready var satisfaction_label: Label = $VBoxContainer/Header/SatisfactionLabel
@onready var school_level_label: Label = $VBoxContainer/Header/SchoolLevelLabel

@onready var classes_container: VBoxContainer = $VBoxContainer/Content/ClassesSection/ClassesContainer
@onready var upgrades_container: VBoxContainer = $VBoxContainer/Content/UpgradesSection/UpgradesContainer

@onready var return_button: Button = $VBoxContainer/Footer/ReturnButton

# Class buttons (will be created dynamically)
var class_buttons: Dictionary = {}

func _ready():
	# Connect signals
	return_button.pressed.connect(_on_return_button_pressed)
	SchoolManager.resources_changed.connect(_on_resources_changed)
	SchoolManager.class_unlocked.connect(_on_class_unlocked)
	SchoolManager.school_level_up.connect(_on_school_level_up)
	
	# Initialize UI
	update_display()
	create_class_buttons()
	create_upgrade_buttons()
	
	print("Magic School UI loaded")

func update_display():
	"""Update all UI elements with current school state"""
	mana_crystals_label.text = "Mana Crystals: " + str(SchoolManager.mana_crystals)
	satisfaction_label.text = "Satisfaction: " + str(int(SchoolManager.student_satisfaction * 100)) + "%"
	school_level_label.text = "School Level: " + str(SchoolManager.school_level)
	
	# Update class buttons
	update_class_buttons()
	update_upgrade_buttons()

func create_class_buttons():
	"""Create buttons for each class type"""
	var class_data = {
		"basic_magic": {"name": "Basic Magic", "earnings": 20, "unlock_cost": 0},  # Already unlocked
		"advanced_magic": {"name": "Advanced Magic", "earnings": 50, "unlock_cost": 100},
		"combat_magic": {"name": "Combat Magic", "earnings": 75, "unlock_cost": 150},
		"healing_magic": {"name": "Healing Magic", "earnings": 60, "unlock_cost": 120},
		"elemental_magic": {"name": "Elemental Magic", "earnings": 100, "unlock_cost": 200}
	}
	
	for class_id in class_data:
		var class_info = class_data[class_id]
		
		var button = Button.new()
		if SchoolManager.is_class_unlocked(class_id):
			button.text = class_info.name + " (+" + str(class_info.earnings) + " crystals)"
		else:
			button.text = class_info.name + " (Unlock: " + str(class_info.unlock_cost) + " crystals)"
		button.custom_minimum_size = Vector2(250, 40)
		button.pressed.connect(_on_class_button_pressed.bind(class_id, class_info.unlock_cost))
		
		classes_container.add_child(button)
		class_buttons[class_id] = button

func create_upgrade_buttons():
	"""Create buttons for school upgrades"""
	var upgrade_data = {
		"library": {"name": "Library", "cost": 50, "description": "Unlocks new spells"},
		"workshop": {"name": "Workshop", "cost": 100, "description": "Craft spell upgrades"},
		"herb_garden": {"name": "Herb Garden", "cost": 75, "description": "Grow spell ingredients"},
		"observation_tower": {"name": "Observation Tower", "cost": 200, "description": "Reveal hidden areas"}
	}
	
	for upgrade_id in upgrade_data:
		var upgrade_info = upgrade_data[upgrade_id]
		var hbox = HBoxContainer.new()
		
		var button = Button.new()
		# Get material requirements
		var material_reqs = SchoolManager.get_upgrade_requirements(upgrade_id)
		var button_text = upgrade_info.name + " (" + str(upgrade_info.cost) + " crystals"
		if not material_reqs.is_empty() and MaterialManager:
			var req_text = ""
			for material_id in material_reqs:
				var material_data = MaterialManager.get_material(material_id)
				var material_name = material_data.get("name", material_id)
				var quantity = material_reqs[material_id]
				if req_text != "":
					req_text += ", "
				req_text += str(quantity) + "x " + material_name
			if req_text != "":
				button_text += " + " + req_text
		button_text += ")"
		button.text = button_text
		button.custom_minimum_size = Vector2(300, 40)
		button.pressed.connect(_on_upgrade_button_pressed.bind(upgrade_id, upgrade_info.cost))
		
		var label = Label.new()
		label.text = upgrade_info.description
		label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		
		hbox.add_child(button)
		hbox.add_child(label)
		upgrades_container.add_child(hbox)

func update_class_buttons():
	"""Update class button states based on unlock status"""
	var class_data = {
		"basic_magic": {"name": "Basic Magic", "earnings": 20, "unlock_cost": 0},
		"advanced_magic": {"name": "Advanced Magic", "earnings": 50, "unlock_cost": 100},
		"combat_magic": {"name": "Combat Magic", "earnings": 75, "unlock_cost": 150},
		"healing_magic": {"name": "Healing Magic", "earnings": 60, "unlock_cost": 120},
		"elemental_magic": {"name": "Elemental Magic", "earnings": 100, "unlock_cost": 200}
	}
	
	for class_id in class_buttons:
		var button = class_buttons[class_id]
		var class_info = class_data[class_id]
		
		if SchoolManager.is_class_unlocked(class_id):
			button.disabled = false
			button.modulate = Color.WHITE
			button.text = class_info.name + " (+" + str(class_info.earnings) + " crystals)"
		else:
			button.disabled = false  # Can click to unlock
			button.modulate = Color(0.8, 0.8, 0.6, 1)  # Slightly yellow for unlockable
			button.text = class_info.name + " (Unlock: " + str(class_info.unlock_cost) + " crystals)"

func update_upgrade_buttons():
	"""Update upgrade button states"""
	for upgrade_id in SchoolManager.school_upgrades:
		if SchoolManager.school_upgrades[upgrade_id]:
			# Find and disable the button for this upgrade
			for child in upgrades_container.get_children():
				var button = child.get_child(0) if child is HBoxContainer else null
				if button and upgrade_id in button.text.to_lower():
					button.disabled = true
					button.text = button.text.split(" (")[0] + " (Purchased)"
					button.modulate = Color(0.7, 0.7, 0.7, 1)

func _on_class_button_pressed(class_id: String, unlock_cost: int):
	"""Handle class teaching button press or unlock"""
	# If class is locked, try to unlock it
	if not SchoolManager.is_class_unlocked(class_id):
		if SchoolManager.unlock_class(class_id, unlock_cost):
			print("Unlocked class: ", class_id)
			update_display()
		else:
			print("Cannot afford to unlock class: ", class_id, " (Need ", unlock_cost, " crystals)")
		return
	
	# Class is unlocked, teach it
	if SchoolManager.teach_class(class_id):
		# Show feedback
		var earnings = SchoolManager.get_class_earnings(class_id)
		var total_earnings = int(earnings * (1.0 + SchoolManager.student_satisfaction))
		print("Taught ", class_id, " - Earned ", total_earnings, " mana crystals!")
		update_display()
	else:
		print("Cannot teach class: ", class_id)

func _on_upgrade_button_pressed(upgrade_id: String, cost: int):
	"""Handle upgrade button press"""
	var material_reqs = SchoolManager.get_upgrade_requirements(upgrade_id)
	if SchoolManager.upgrade_school(upgrade_id, cost, material_reqs):
		print("Upgraded: ", upgrade_id)
		update_display()
	else:
		var error_msg = "Cannot afford upgrade: " + upgrade_id + " (Need " + str(cost) + " crystals"
		if not material_reqs.is_empty() and MaterialManager:
			for material_id in material_reqs:
				var material_data = MaterialManager.get_material(material_id)
				var material_name = material_data.get("name", material_id)
				var required = material_reqs[material_id]
				var has = MaterialManager.get_material_quantity(material_id)
				error_msg += ", " + str(required) + "x " + material_name + " (have " + str(has) + ")"
		error_msg += ")"
		print(error_msg)

func _on_return_button_pressed():
	"""Return to previous scene (test level or main menu)"""
	GameManager.change_scene("res://scenes/test_level.tscn")

func _on_resources_changed(mana_crystals: int):
	"""Update UI when resources change"""
	update_display()

func _on_class_unlocked(unlocked_class: String):
	"""Update UI when a class is unlocked"""
	update_display()

func _on_school_level_up(new_level: int):
	"""Update UI when school levels up"""
	update_display()
