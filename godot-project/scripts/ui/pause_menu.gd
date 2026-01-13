extends Control

## Pause Menu - Appears when player presses Escape

@onready var resume_button: Button = $VBoxContainer/ResumeButton
@onready var main_menu_button: Button = $VBoxContainer/MainMenuButton
@onready var quit_button: Button = $VBoxContainer/QuitButton

var is_paused: bool = false

func _ready():
	# Make sure this UI processes even when game is paused
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Connect button signals
	resume_button.pressed.connect(_on_resume_button_pressed)
	main_menu_button.pressed.connect(_on_main_menu_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	
	# Hide menu initially
	visible = false
	
	print("Pause menu loaded")

func _unhandled_input(event):
	"""Handle Escape key to toggle pause menu - use unhandled so it works even when other nodes consume input"""
	# This works even when paused because process_mode is PROCESS_MODE_ALWAYS
	if event is InputEventKey and event.pressed and not event.echo:
		# Check both action and direct keycode
		if event.is_action("pause_menu") or event.keycode == KEY_ESCAPE:
			toggle_pause()
			get_viewport().set_input_as_handled()

func toggle_pause():
	"""Toggle pause state"""
	is_paused = !is_paused
	
	if is_paused:
		show_pause_menu()
	else:
		hide_pause_menu()

func show_pause_menu():
	"""Show pause menu and pause game"""
	visible = true
	GameManager.pause_game()
	resume_button.grab_focus()
	print("Game paused")

func hide_pause_menu():
	"""Hide pause menu and resume game"""
	visible = false
	GameManager.resume_game()
	print("Game resumed")

func _on_resume_button_pressed():
	"""Resume the game"""
	hide_pause_menu()

func _on_main_menu_button_pressed():
	"""Return to main menu"""
	GameManager.resume_game()  # Unpause first
	GameManager.change_scene("res://scenes/start_menu.tscn")

func _on_quit_button_pressed():
	"""Quit the game"""
	print("Quitting game...")
	get_tree().quit()
