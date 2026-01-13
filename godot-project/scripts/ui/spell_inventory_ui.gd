extends VBoxContainer

## Spell Inventory UI - Shows equipped spells

@onready var slot1_label: Label = $SpellSlot1/SpellName
@onready var slot2_label: Label = $SpellSlot2/SpellName
@onready var slot3_label: Label = $SpellSlot3/SpellName
@onready var slot4_label: Label = $SpellSlot4/SpellName

var spell_labels: Array[Label] = []

func _ready():
	spell_labels = [slot1_label, slot2_label, slot3_label, slot4_label]
	update_display()

func _on_spell_collected(spell_data: Dictionary):
	"""Update UI when player collects a spell"""
	update_display()

func _on_current_spell_changed(slot: int):
	"""Update UI when player switches spells"""
	update_display()

func update_display():
	"""Update spell inventory display"""
	# Find player in scene
	var player = get_tree().get_first_node_in_group("player")
	if not player:
		return
	
	# Update each slot
	for i in range(spell_labels.size()):
		var label = spell_labels[i]
		if i < player.equipped_spells.size():
			var spell = player.equipped_spells[i]
			if spell != null and spell is Dictionary:
				var spell_name = spell.get("name", "Unknown")
				# Highlight current spell
				if i == player.current_spell_slot:
					label.text = "> " + spell_name + " <"
					label.modulate = Color(1, 1, 0.5, 1)  # Yellow highlight
				else:
					label.text = spell_name
					label.modulate = Color.WHITE
			else:
				if i == player.current_spell_slot:
					label.text = "> Empty <"
				else:
					label.text = "Empty"
				label.modulate = Color(0.5, 0.5, 0.5, 1)
		else:
			if i == player.current_spell_slot:
				label.text = "> Empty <"
			else:
				label.text = "Empty"
			label.modulate = Color(0.5, 0.5, 0.5, 1)

func _process(_delta):
	# Update display periodically to catch changes
	update_display()
