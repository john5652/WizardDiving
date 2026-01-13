extends Button

## Return to School Button - Appears in exploration areas

func _ready():
	text = "🏫 Return to School"
	pressed.connect(_on_pressed)
	
	# Position in bottom-right corner
	anchor_left = 1.0
	anchor_top = 1.0
	anchor_right = 1.0
	anchor_bottom = 1.0
	offset_left = -200.0
	offset_top = -60.0
	offset_right = -20.0
	offset_bottom = -20.0
	custom_minimum_size = Vector2(180, 40)

func _on_pressed():
	"""Return to School Hub"""
	print("Returning to School...")
	GameManager.change_scene("res://scenes/school_hub.tscn")
