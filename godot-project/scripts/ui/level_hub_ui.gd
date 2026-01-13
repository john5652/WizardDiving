extends Control

## Level Hub UI - Where player selects which biome to explore

@onready var dark_forest_button: Button = $VBoxContainer/DarkForestButton
@onready var dungeon_button: Button = $VBoxContainer/DungeonButton
@onready var village_button: Button = $VBoxContainer/VillageButton
@onready var return_to_school_button: Button = $VBoxContainer/ReturnToSchoolButton

func _ready():
	# Connect button signals
	dark_forest_button.pressed.connect(_on_dark_forest_pressed)
	dungeon_button.pressed.connect(_on_dungeon_pressed)
	village_button.pressed.connect(_on_village_pressed)
	return_to_school_button.pressed.connect(_on_return_to_school_pressed)
	
	# Focus first button for keyboard navigation
	dark_forest_button.grab_focus()
	
	print("Level Hub loaded - Select where to explore!")

func _on_dark_forest_pressed():
	"""Travel to Dark Forest biome"""
	print("Traveling to Dark Forest...")
	GameManager.change_scene("res://scenes/dark_forest_level.tscn")

func _on_dungeon_pressed():
	"""Travel to Dungeon biome"""
	print("Traveling to Dungeon...")
	GameManager.change_scene("res://scenes/dungeon_level.tscn")

func _on_village_pressed():
	"""Travel to Village biome"""
	print("Traveling to Village...")
	GameManager.change_scene("res://scenes/village_level.tscn")

func _on_return_to_school_pressed():
	"""Return to School Hub"""
	print("Returning to School...")
	GameManager.change_scene("res://scenes/school_hub.tscn")
