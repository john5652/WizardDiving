extends ProgressBar

## Enemy Health Bar - Updates based on enemy health

func _on_enemy_health_changed(new_health: int, max_health: int):
	"""Update health bar when enemy health changes"""
	max_value = max_health
	value = new_health
	
	# Change color based on health percentage
	var health_percent = float(new_health) / float(max_health)
	if health_percent > 0.6:
		modulate = Color.GREEN
	elif health_percent > 0.3:
		modulate = Color.YELLOW
	else:
		modulate = Color.RED
