extends Label

## Shows feedback when spells are collected

var show_time: float = 0.0
var max_show_time: float = 2.0

func _ready():
	text = ""
	modulate = Color.WHITE
	horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vertical_alignment = VERTICAL_ALIGNMENT_CENTER

func _process(delta):
	if show_time > 0:
		show_time -= delta
		if show_time <= 0:
			text = ""
			modulate = Color.WHITE

func show_collection(spell_name: String, slot: int):
	text = "✓ Collected: " + spell_name + "\nPress " + str(slot) + " to cast!"
	modulate = Color(0.2, 1, 0.2, 1)
	show_time = max_show_time
