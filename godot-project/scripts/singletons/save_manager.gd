extends Node

## Save Manager - Singleton
## Handles saving and loading game state

const SAVE_FILE_PATH = "user://save_game.dat"
const AUTO_SAVE_PATH = "user://auto_save.dat"

signal game_saved
signal game_loaded

# Track defeated enemies: Dictionary[room_id: Dictionary[enemy_id: true]]
var defeated_enemies: Dictionary = {}
# Track collected pickups: Dictionary[room_id: Dictionary[pickup_id: true]]
var collected_pickups: Dictionary = {}
# Track unlocked doors: Dictionary[room_id: Dictionary[door_id: true]]
var unlocked_doors: Dictionary = {}

func _ready():
	print("Save Manager initialized")

func save_game(slot: int = 0, is_auto_save: bool = false) -> bool:
	"""Save the current game state"""
	var save_data = collect_save_data()
	
	var file_path = AUTO_SAVE_PATH if is_auto_save else SAVE_FILE_PATH
	if slot > 0:
		file_path = "user://save_game_%d.dat" % slot
	
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	if file == null:
		push_error("Failed to open save file for writing: " + file_path)
		return false
	
	# Convert save data to JSON
	var json_string = JSON.stringify(save_data)
	file.store_string(json_string)
	file.close()
	
	print("Game saved to: ", file_path)
	game_saved.emit()
	return true

func load_game(slot: int = 0, is_auto_save: bool = false) -> bool:
	"""Load game state from file"""
	var file_path = AUTO_SAVE_PATH if is_auto_save else SAVE_FILE_PATH
	if slot > 0:
		file_path = "user://save_game_%d.dat" % slot
	
	if not FileAccess.file_exists(file_path):
		push_error("Save file does not exist: " + file_path)
		return false
	
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		push_error("Failed to open save file for reading: " + file_path)
		return false
	
	var json_string = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if parse_result != OK:
		push_error("Failed to parse save file JSON")
		return false
	
	var save_data = json.data
	apply_save_data(save_data)
	
	print("Game loaded from: ", file_path)
	game_loaded.emit()
	return true

func collect_save_data() -> Dictionary:
	"""Collect all game state data to save"""
	var save_data = {
		"version": "1.0",
		"timestamp": Time.get_unix_time_from_system(),
		"player": {},
		"school": {},
		"quests": {},
		"scene": "",
		"defeated_enemies": defeated_enemies,
		"collected_pickups": collected_pickups,
		"unlocked_doors": unlocked_doors
	}
	
	# Save player data
	var player = get_tree().get_first_node_in_group("player")
	if player:
		save_data["player"] = {
			"health": player.current_health,
			"max_health": player.max_health,
			"position": {
				"x": player.global_position.x,
				"y": player.global_position.y
			},
			"collected_spells": player.collected_spells,
			"equipped_spells": player.equipped_spells,
			"current_spell_slot": player.current_spell_slot
		}
	
	# Save school data
	if SchoolManager:
		save_data["school"] = {
			"school_level": SchoolManager.school_level,
			"mana_crystals": SchoolManager.mana_crystals,
			"student_satisfaction": SchoolManager.student_satisfaction,
			"unlocked_classes": SchoolManager.unlocked_classes,
			"school_upgrades": SchoolManager.school_upgrades
		}
	
	# Save quest data
	if QuestManager:
		save_data["quests"] = {
			"active_quests": serialize_quests(QuestManager.active_quests),
			"completed_quests": serialize_quests(QuestManager.completed_quests),
			"available_quests": serialize_quests(QuestManager.available_quests)
		}
	
	# Save current scene
	if GameManager:
		save_data["scene"] = GameManager.current_scene
	
	return save_data

func apply_save_data(save_data: Dictionary):
	"""Apply loaded save data to game state"""
	# Load school data first (doesn't depend on scene)
	if save_data.has("school") and SchoolManager:
		var school_data = save_data["school"]
		SchoolManager.school_level = school_data.get("school_level", 1)
		SchoolManager.mana_crystals = school_data.get("mana_crystals", 100)
		SchoolManager.student_satisfaction = school_data.get("student_satisfaction", 0.5)
		
		# Convert array to Array[String] type
		var unlocked_classes_data = school_data.get("unlocked_classes", ["basic_magic"])
		var unlocked_classes_array: Array[String] = []
		if unlocked_classes_data is Array:
			for item in unlocked_classes_data:
				unlocked_classes_array.append(str(item))
		SchoolManager.unlocked_classes = unlocked_classes_array
		
		SchoolManager.school_upgrades = school_data.get("school_upgrades", {})
		SchoolManager.resources_changed.emit(SchoolManager.mana_crystals)
	
	# Load quest data (doesn't depend on scene)
	if save_data.has("quests") and QuestManager:
		var quest_data = save_data["quests"]
		QuestManager.active_quests = deserialize_quests(quest_data.get("active_quests", []))
		QuestManager.completed_quests = deserialize_quests(quest_data.get("completed_quests", []))
		QuestManager.available_quests = deserialize_quests(quest_data.get("available_quests", []))
	
	# Load defeated enemies data
	if save_data.has("defeated_enemies"):
		defeated_enemies = save_data["defeated_enemies"]
	
	# Load collected pickups data
	if save_data.has("collected_pickups"):
		collected_pickups = save_data["collected_pickups"]
	
	# Load unlocked doors data
	if save_data.has("unlocked_doors"):
		unlocked_doors = save_data["unlocked_doors"]
	
	# Load scene first, then apply player data after scene is loaded
	if save_data.has("scene") and GameManager and save_data["scene"] != "":
		var scene_path = save_data["scene"]
		if ResourceLoader.exists(scene_path):
			GameManager.change_scene(scene_path)
			# Wait for scene to be ready before applying player data
			await get_tree().process_frame
			await get_tree().process_frame  # Extra frame to ensure scene is fully loaded
	
	# Load player data (after scene is loaded)
	if save_data.has("player"):
		var player_data = save_data["player"]
		# Try to find player - wait a bit if not found
		var player = get_tree().get_first_node_in_group("player")
		var attempts = 0
		while not player and attempts < 10:
			await get_tree().process_frame
			player = get_tree().get_first_node_in_group("player")
			attempts += 1
		
		if player:
			if player_data.has("health"):
				player.current_health = player_data.get("health", player.max_health)
				player.max_health = player_data.get("max_health", 100)
				player.health_changed.emit(player.current_health, player.max_health)
			
			if player_data.has("position"):
				var pos = player_data["position"]
				player.global_position = Vector2(pos.get("x", 0), pos.get("y", 0))
			
			if player_data.has("collected_spells"):
				# Convert array to Array[Dictionary] type
				var collected_spells_data = player_data["collected_spells"]
				var collected_spells_array: Array[Dictionary] = []
				if collected_spells_data is Array:
					for spell in collected_spells_data:
						if spell is Dictionary:
							collected_spells_array.append(spell)
				player.collected_spells = collected_spells_array
				
				# Sync SpellManager's player_spells with player's collected_spells
				if SpellManager:
					SpellManager.player_spells = collected_spells_array.duplicate()
			
			if player_data.has("equipped_spells"):
				# Convert array - equipped_spells can contain Dictionary or null
				var equipped_spells_data = player_data["equipped_spells"]
				var equipped_spells_array = []
				if equipped_spells_data is Array:
					for spell in equipped_spells_data:
						if spell == null:
							equipped_spells_array.append(null)
						elif spell is Dictionary:
							equipped_spells_array.append(spell)
				player.equipped_spells = equipped_spells_array
			
			if player_data.has("current_spell_slot"):
				player.current_spell_slot = player_data["current_spell_slot"]
				player.current_spell_changed.emit(player.current_spell_slot)
		else:
			push_warning("Player not found when loading save data")

func serialize_quests(quests: Array) -> Array:
	"""Convert Quest objects to dictionaries for saving"""
	var serialized = []
	for quest in quests:
		if quest.has_method("get_quest_data"):
			serialized.append(quest.get_quest_data())
		else:
			# Fallback: serialize basic quest data
			var quest_dict = {
				"quest_id": quest.quest_id if quest.has("quest_id") else "",
				"quest_name": quest.quest_name if quest.has("quest_name") else "",
				"description": quest.description if quest.has("description") else "",
				"quest_type": quest.quest_type if quest.has("quest_type") else "side",
				"objectives": quest.objectives if quest.has("objectives") else [],
				"rewards": quest.rewards if quest.has("rewards") else {},
				"is_active": quest.is_active if quest.has("is_active") else false,
				"is_completed": quest.is_completed if quest.has("is_completed") else false
			}
			serialized.append(quest_dict)
	return serialized

func deserialize_quests(quest_data: Array) -> Array:
	"""Convert dictionaries back to Quest objects"""
	var quests = []
	for quest_dict in quest_data:
		var quest = Quest.new()
		quest.quest_id = quest_dict.get("quest_id", "")
		quest.quest_name = quest_dict.get("quest_name", "")
		quest.description = quest_dict.get("description", "")
		quest.quest_type = quest_dict.get("quest_type", "side")
		
		# Convert objectives array to Array[Dictionary] type
		var objectives_data = quest_dict.get("objectives", [])
		var objectives_array: Array[Dictionary] = []
		if objectives_data is Array:
			for obj in objectives_data:
				if obj is Dictionary:
					objectives_array.append(obj)
		quest.objectives = objectives_array
		
		quest.rewards = quest_dict.get("rewards", {})
		quest.is_active = quest_dict.get("is_active", false)
		quest.is_completed = quest_dict.get("is_completed", false)
		quests.append(quest)
	return quests

func auto_save():
	"""Perform an auto-save"""
	save_game(0, true)
	print("Auto-save completed")

func has_save_file(slot: int = 0) -> bool:
	"""Check if a save file exists"""
	var file_path = SAVE_FILE_PATH
	if slot > 0:
		file_path = "user://save_game_%d.dat" % slot
	return FileAccess.file_exists(file_path)

func has_auto_save() -> bool:
	"""Check if an auto-save file exists"""
	return FileAccess.file_exists(AUTO_SAVE_PATH)

func delete_save(slot: int = 0) -> bool:
	"""Delete a save file"""
	var file_path = SAVE_FILE_PATH
	if slot > 0:
		file_path = "user://save_game_%d.dat" % slot
	
	if not FileAccess.file_exists(file_path):
		return false
	
	DirAccess.remove_absolute(file_path)
	print("Save file deleted: ", file_path)
	return true

func get_save_timestamp(slot: int = 0) -> int:
	"""Get the timestamp of a save file"""
	var file_path = SAVE_FILE_PATH
	if slot > 0:
		file_path = "user://save_game_%d.dat" % slot
	
	if not FileAccess.file_exists(file_path):
		return 0
	
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		return 0
	
	var json_string = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	if json.parse(json_string) != OK:
		return 0
	
	var save_data = json.data
	return save_data.get("timestamp", 0)

func register_enemy_defeated(room_id: String, enemy_id: String):
	"""Register an enemy as defeated"""
	if not defeated_enemies.has(room_id):
		defeated_enemies[room_id] = {}
	defeated_enemies[room_id][enemy_id] = true

func is_enemy_defeated(room_id: String, enemy_id: String) -> bool:
	"""Check if an enemy has been defeated"""
	if not defeated_enemies.has(room_id):
		return false
	return defeated_enemies[room_id].get(enemy_id, false)

func register_pickup_collected(room_id: String, pickup_id: String):
	"""Register a pickup as collected"""
	if not collected_pickups.has(room_id):
		collected_pickups[room_id] = {}
	collected_pickups[room_id][pickup_id] = true

func is_pickup_collected(room_id: String, pickup_id: String) -> bool:
	"""Check if a pickup has been collected"""
	if not collected_pickups.has(room_id):
		return false
	return collected_pickups[room_id].get(pickup_id, false)

func register_door_unlocked(room_id: String, door_id: String):
	"""Register a door as unlocked"""
	if not unlocked_doors.has(room_id):
		unlocked_doors[room_id] = {}
	unlocked_doors[room_id][door_id] = true

func is_door_unlocked(room_id: String, door_id: String) -> bool:
	"""Check if a door has been unlocked"""
	if not unlocked_doors.has(room_id):
		return false
	return unlocked_doors[room_id].get(door_id, false)
