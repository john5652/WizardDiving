extends ProgressBar

## Health Bar UI - Updates based on player health

@onready var health_label: Label = $HealthLabel

func _on_player_health_changed(new_health: int, max_health: int):
	"""Update health bar when player health changes"""
	max_value = max_health
	value = new_health
	
	if health_label:
		health_label.text = "Health: %d/%d" % [new_health, max_health]
	
	# Change color based on health percentage
	var health_percent = float(new_health) / float(max_health)
	if health_percent > 0.6:
		modulate = Color.GREEN
	elif health_percent > 0.3:
		modulate = Color.YELLOW
	else:
		modulate = Color.RED
