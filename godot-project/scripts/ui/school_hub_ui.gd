extends Control

## School Hub UI - Physical school scene with UI overlay

@onready var go_explore_button: Button = $VBoxContainer/GoExploreButton
@onready var school_management_button: Button = $VBoxContainer/SchoolManagementButton
@onready var quest_log_button: Button = $VBoxContainer/QuestLogButton

func _ready():
	# Connect button signals
	go_explore_button.pressed.connect(_on_go_explore_pressed)
	school_management_button.pressed.connect(_on_school_management_pressed)
	quest_log_button.pressed.connect(_on_quest_log_pressed)
	
	print("School Hub loaded - Welcome back to your magic school!")

func _on_go_explore_pressed():
	"""Go to level selection hub"""
	print("Going to explore...")
	GameManager.change_scene("res://scenes/level_hub.tscn")

func _on_school_management_pressed():
	"""Open Magic School Management UI"""
	print("Opening School Management...")
	# Load and instantiate magic school UI
	var school_ui_scene = load("res://scenes/magic_school.tscn")
	if school_ui_scene:
		var school_instance = school_ui_scene.instantiate()
		# Add to UI layer
		var ui_layer = get_tree().get_first_node_in_group("ui_layer")
		if not ui_layer:
			ui_layer = get_parent()
		ui_layer.add_child(school_instance)
		# Make sure it's visible and on top
		school_instance.z_index = 100
		print("School Management UI opened")
	else:
		print("ERROR: Could not load magic_school.tscn")

func _on_quest_log_pressed():
	"""Open Quest Log"""
	print("Opening Quest Log...")
	var quest_log = load("res://scenes/quest_log.tscn")
	if quest_log:
		var quest_log_instance = quest_log.instantiate()
		add_child(quest_log_instance)
