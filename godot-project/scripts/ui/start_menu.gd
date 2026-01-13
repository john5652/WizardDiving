extends Control

## Start Menu - Main menu screen

@onready var start_button: Button = $VBoxContainer/StartButton
@onready var quit_button: Button = $VBoxContainer/QuitButton

func _ready():
	# Connect button signals
	start_button.pressed.connect(_on_start_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	
	# Make sure buttons are focused for keyboard navigation
	start_button.grab_focus()
	
	print("Start menu loaded")

func _on_start_button_pressed():
	"""Start the game - load test level"""
	print("Starting game...")
	GameManager.change_scene("res://scenes/test_level.tscn")

func _on_quit_button_pressed():
	"""Quit the game"""
	print("Quitting game...")
	get_tree().quit()

func _input(event):
	"""Handle keyboard input"""
	if event.is_action_pressed("ui_accept") and start_button.has_focus():
		_on_start_button_pressed()
	elif event.is_action_pressed("ui_cancel"):
		_on_quit_button_pressed()
