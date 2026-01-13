extends Node

## Game Manager - Singleton
## Manages global game state, scene transitions, and game-wide systems

signal scene_changed(new_scene: String)
signal player_died
signal game_paused
signal game_resumed

var current_scene: String = ""
var player_data: Dictionary = {}
var game_settings: Dictionary = {
	"master_volume": 1.0,
	"sfx_volume": 1.0,
	"music_volume": 1.0,
	"fullscreen": false
}

func _ready():
	load_game_settings()
	print("Game Manager initialized")

func change_scene(scene_path: String):
	"""Change to a new scene"""
	if ResourceLoader.exists(scene_path):
		current_scene = scene_path
		get_tree().change_scene_to_file(scene_path)
		scene_changed.emit(scene_path)
		
		# Auto-save when returning to school (if SaveManager exists)
		if SaveManager and "magic_school" in scene_path.to_lower():
			SaveManager.auto_save()
	else:
		push_error("Scene not found: " + scene_path)

func pause_game():
	"""Pause the game"""
	get_tree().paused = true
	game_paused.emit()

func resume_game():
	"""Resume the game"""
	get_tree().paused = false
	game_resumed.emit()

func save_game_settings():
	"""Save game settings to file"""
	var config = ConfigFile.new()
	for key in game_settings:
		config.set_value("settings", key, game_settings[key])
	config.save("user://settings.cfg")

func load_game_settings():
	"""Load game settings from file"""
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err == OK:
		for key in game_settings:
			game_settings[key] = config.get_value("settings", key, game_settings[key])
