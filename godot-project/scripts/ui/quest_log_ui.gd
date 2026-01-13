extends Control

## Quest Log UI - Displays active quests and progress

@onready var quests_container: VBoxContainer = $VBoxContainer/ScrollContainer/QuestsContainer
@onready var close_button: Button = $VBoxContainer/Footer/CloseButton
@onready var notification_label: Label = $VBoxContainer/NotificationLabel

var quest_items: Dictionary = {}  # Track quest UI items
var notification_timer: float = 0.0

func _ready():
	# Add to quest_log group for easy access
	add_to_group("quest_log")
	
	# Make sure this processes even when game is paused
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Connect signals
	close_button.pressed.connect(_on_close_button_pressed)
	QuestManager.quest_started.connect(_on_quest_started)
	QuestManager.quest_completed.connect(_on_quest_completed)
	
	# Connect to quest objective completion signals
	for quest in QuestManager.active_quests:
		quest.objective_completed.connect(_on_objective_completed)
		quest.quest_completed.connect(_on_quest_completed_internal)
	
	# Hide notification initially
	notification_label.visible = false
	
	# Auto-start the first available quest if none are active
	if QuestManager.active_quests.is_empty() and QuestManager.available_quests.size() > 0:
		var first_quest = QuestManager.available_quests[0]
		QuestManager.start_quest(first_quest)
		# Connect signals for the new quest
		first_quest.objective_completed.connect(_on_objective_completed)
		first_quest.quest_completed.connect(_on_quest_completed_internal)
	
	# Initialize display
	update_display()
	
	print("Quest Log UI loaded - visible: ", visible)

func _process(delta):
	# Handle notification timer
	if notification_timer > 0:
		notification_timer -= delta
		if notification_timer <= 0:
			notification_label.visible = false

func update_display():
	"""Update the quest log display"""
	# Clear existing quest items
	for child in quests_container.get_children():
		child.queue_free()
	quest_items.clear()
	
	# Display active quests
	if QuestManager.active_quests.is_empty():
		var no_quests_label = Label.new()
		no_quests_label.text = "No active quests"
		no_quests_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		no_quests_label.modulate = Color(0.7, 0.7, 0.7, 1)
		quests_container.add_child(no_quests_label)
	else:
		for quest in QuestManager.active_quests:
			create_quest_item(quest)

func create_quest_item(quest: Quest):
	"""Create a UI item for a quest"""
	var quest_panel = VBoxContainer.new()
	quest_panel.custom_minimum_size = Vector2(0, 100)
	
	# Quest header
	var header = HBoxContainer.new()
	
	var quest_name_label = Label.new()
	quest_name_label.text = quest.quest_name
	quest_name_label.add_theme_font_size_override("font_size", 20)
	quest_name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	var quest_type_label = Label.new()
	quest_type_label.text = "[" + quest.quest_type.to_upper() + "]"
	quest_type_label.modulate = get_quest_type_color(quest.quest_type)
	
	header.add_child(quest_name_label)
	header.add_child(quest_type_label)
	
	# Quest description
	var description_label = Label.new()
	description_label.text = quest.description
	description_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	description_label.modulate = Color(0.9, 0.9, 0.9, 1)
	
	# Objectives
	var objectives_container = VBoxContainer.new()
	objectives_container.add_theme_constant_override("separation", 5)
	
	for i in range(quest.objectives.size()):
		var objective = quest.objectives[i]
		var objective_item = create_objective_item(objective, i)
		objectives_container.add_child(objective_item)
	
	# Progress bar
	var progress_bar = ProgressBar.new()
	progress_bar.max_value = 1.0
	progress_bar.value = quest.get_progress()
	progress_bar.custom_minimum_size = Vector2(0, 20)
	
	# Rewards preview
	var rewards_label = Label.new()
	rewards_label.text = "Rewards: " + format_rewards(quest.rewards)
	rewards_label.modulate = Color(0.8, 0.8, 0.5, 1)
	rewards_label.add_theme_font_size_override("font_size", 12)
	
	# Assemble quest panel
	quest_panel.add_child(header)
	quest_panel.add_child(description_label)
	quest_panel.add_child(objectives_container)
	quest_panel.add_child(progress_bar)
	quest_panel.add_child(rewards_label)
	
	# Add separator
	var separator = HSeparator.new()
	quest_panel.add_child(separator)
	
	quests_container.add_child(quest_panel)
	quest_items[quest.quest_id] = quest_panel

func create_objective_item(objective: Dictionary, index: int) -> HBoxContainer:
	"""Create a UI item for an objective"""
	var hbox = HBoxContainer.new()
	
	# Checkbox/status indicator
	var status_label = Label.new()
	if objective.get("completed", false):
		status_label.text = "✓"
		status_label.modulate = Color(0.3, 1.0, 0.3, 1)
	else:
		status_label.text = "○"
		status_label.modulate = Color(0.7, 0.7, 0.7, 1)
	status_label.custom_minimum_size = Vector2(20, 0)
	
	# Objective description
	var objective_label = Label.new()
	objective_label.text = objective.get("description", "Unknown objective")
	if objective.get("completed", false):
		objective_label.modulate = Color(0.6, 0.6, 0.6, 1)
	
	objective_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	hbox.add_child(status_label)
	hbox.add_child(objective_label)
	
	return hbox

func get_quest_type_color(quest_type: String) -> Color:
	"""Get color for quest type"""
	match quest_type:
		"main":
			return Color(1.0, 0.8, 0.3, 1)  # Gold
		"side":
			return Color(0.5, 0.8, 1.0, 1)  # Blue
		"collection":
			return Color(0.8, 0.5, 1.0, 1)  # Purple
		"exploration":
			return Color(0.5, 1.0, 0.5, 1)  # Green
		_:
			return Color.WHITE

func format_rewards(rewards: Dictionary) -> String:
	"""Format rewards dictionary as string"""
	var reward_strings = []
	
	if rewards.has("mana_crystals"):
		reward_strings.append(str(rewards["mana_crystals"]) + " Mana Crystals")
	if rewards.has("experience"):
		reward_strings.append(str(rewards["experience"]) + " XP")
	if rewards.has("spell"):
		reward_strings.append("Spell: " + str(rewards["spell"]))
	
	if reward_strings.is_empty():
		return "None"
	
	return ", ".join(reward_strings)

func show_notification(text: String, duration: float = 3.0):
	"""Show a notification message"""
	notification_label.text = text
	notification_label.visible = true
	notification_timer = duration

func _on_quest_started(quest: Quest):
	"""Handle quest started event"""
	# Connect to quest signals
	quest.objective_completed.connect(_on_objective_completed)
	quest.quest_completed.connect(_on_quest_completed_internal)
	
	update_display()
	show_notification("Quest Started: " + quest.quest_name)

func _on_quest_completed(quest: Quest):
	"""Handle quest completed event"""
	update_display()
	show_notification("Quest Completed: " + quest.quest_name + "! Rewards received.")

func _on_objective_completed(objective_index: int):
	"""Handle objective completion - update display"""
	update_display()

func _on_quest_completed_internal(quest: Quest):
	"""Handle quest completion from quest signal"""
	# QuestManager will also emit quest_completed, but we update here too
	update_display()

func _on_close_button_pressed():
	"""Close the quest log"""
	visible = false
	# Resume game if it was paused
	if get_tree().paused:
		GameManager.resume_game()

func toggle_visibility():
	"""Toggle quest log visibility"""
	visible = !visible
	if visible:
		update_display()
		close_button.grab_focus()
		print("Quest log opened")
	else:
		print("Quest log closed")
