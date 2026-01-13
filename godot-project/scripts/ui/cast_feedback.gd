extends Label

## Visual feedback when casting spells

var feedback_time: float = 0.0
var max_feedback_time: float = 0.3

func _ready():
	text = ""
	modulate = Color.WHITE

func _process(delta):
	if feedback_time > 0:
		feedback_time -= delta
		if feedback_time <= 0:
			text = ""
			modulate = Color.WHITE

func show_cast(spell_name: String):
	text = "Casting: " + spell_name
	modulate = Color(1, 1, 0.5, 1)
	feedback_time = max_feedback_time
