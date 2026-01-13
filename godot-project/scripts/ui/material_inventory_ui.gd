extends VBoxContainer

## Material Inventory UI - Shows collected materials

@onready var materials_list: VBoxContainer = $MaterialsList
@onready var label: Label = $Label

var material_items: Dictionary = {}  # material_id -> Label node

func _ready():
	if not MaterialManager:
		print("ERROR: MaterialManager not found!")
		return
	
	# Connect to material manager signals
	MaterialManager.material_collected.connect(_on_material_collected)
	MaterialManager.materials_changed.connect(_on_materials_changed)
	
	update_display()

func _on_material_collected(material_id: String, quantity: int):
	"""Update UI when material is collected"""
	update_display()

func _on_materials_changed():
	"""Update UI when materials change"""
	update_display()

func update_display():
	"""Update material inventory display"""
	if not MaterialManager:
		return
	
	# Clear existing items
	for child in materials_list.get_children():
		child.queue_free()
	material_items.clear()
	
	# Get all player materials
	var player_materials = MaterialManager.get_all_player_materials()
	
	if player_materials.is_empty():
		var empty_label = Label.new()
		empty_label.text = "No materials collected"
		empty_label.modulate = Color(0.6, 0.6, 0.6, 1)
		materials_list.add_child(empty_label)
		return
	
	# Display each material
	for material_id in player_materials:
		var quantity = player_materials[material_id]
		var material_data = MaterialManager.get_material(material_id)
		
		if material_data.is_empty():
			continue
		
		var material_name = material_data.get("name", material_id)
		var material_type = material_data.get("type", "unknown")
		var icon_color = material_data.get("icon_color", Color.WHITE)
		
		# Create label for this material
		var material_label = Label.new()
		var display_text = "• %s x%d" % [material_name, quantity]
		material_label.text = display_text
		material_label.modulate = icon_color
		
		# Add tooltip with description
		var description = material_data.get("description", "")
		if description != "":
			material_label.tooltip_text = description + " (" + material_type + ")"
		
		materials_list.add_child(material_label)
		material_items[material_id] = material_label
