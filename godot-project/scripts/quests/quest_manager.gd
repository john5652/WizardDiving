extends Node

## Quest Manager - Handles quest system and AI-generated content

var active_quests: Array = []  # Array of Quest resources
var completed_quests: Array = []  # Array of Quest resources
var available_quests: Array = []  # Array of Quest resources

signal quest_started(quest: Resource)
signal quest_completed(quest: Resource)

func _ready():
	initialize_quests()
	print("Quest Manager initialized")

func initialize_quests():
	"""Initialize starting quests"""
	# Example main quest
	var main_quest = Quest.new()
	main_quest.quest_id = "main_001"
	main_quest.quest_name = "The First Spell"
	main_quest.description = "Collect your first spell to begin your journey"
	main_quest.quest_type = "main"
	var objectives_array: Array[Dictionary] = [
		{"description": "Collect a spell", "completed": false, "type": "collect_spell"}
	]
	main_quest.objectives = objectives_array
	main_quest.rewards = {"mana_crystals": 50, "experience": 100}
	
	available_quests.append(main_quest)

func start_quest(quest: Quest):
	"""Start a quest"""
	if quest in active_quests:
		return
	
	quest.is_active = true
	active_quests.append(quest)
	quest_started.emit(quest)
	print("Quest started: ", quest.quest_name)

func complete_quest(quest: Quest):
	"""Complete a quest and give rewards"""
	if quest not in active_quests:
		return
	
	quest.is_completed = true
	active_quests.erase(quest)
	completed_quests.append(quest)
	
	# Give rewards
	give_rewards(quest.rewards)
	
	quest_completed.emit(quest)
	print("Quest completed: ", quest.quest_name)

func give_rewards(rewards: Dictionary):
	"""Give quest rewards to player"""
	if rewards.has("mana_crystals"):
		if SchoolManager:
			SchoolManager.mana_crystals += rewards["mana_crystals"]
	
	if rewards.has("experience"):
		# TODO: Give experience to player
		pass
	
	if rewards.has("spell"):
		# TODO: Give spell to player
		pass

func generate_quest_ai(quest_type: String = "side") -> Quest:
	"""Generate a quest using AI (placeholder for future AI integration)"""
	var quest = Quest.new()
	quest.quest_id = "ai_quest_" + str(randi())
	quest.quest_name = generate_quest_name()
	quest.description = generate_quest_description()
	quest.quest_type = quest_type
	var objectives_array: Array[Dictionary] = generate_objectives()
	quest.objectives = objectives_array
	quest.rewards = generate_rewards()
	
	return quest

func generate_quest_name() -> String:
	"""Generate a quest name (placeholder)"""
	var prefixes = ["The", "A", "Seeking", "Finding"]
	var nouns = ["Lost", "Ancient", "Mysterious", "Hidden"]
	var objects = ["Spell", "Artifact", "Crystal", "Tome"]
	
	return prefixes[randi() % prefixes.size()] + " " + \
		   nouns[randi() % nouns.size()] + " " + \
		   objects[randi() % objects.size()]

func generate_quest_description() -> String:
	"""Generate quest description (placeholder)"""
	return "An AI-generated quest description. This will be replaced with actual AI generation."

func generate_objectives() -> Array[Dictionary]:
	"""Generate quest objectives (placeholder)"""
	return [
		{"description": "Collect 3 spells", "completed": false, "type": "collect"},
		{"description": "Defeat 5 enemies", "completed": false, "type": "combat"}
	]

func generate_rewards() -> Dictionary:
	"""Generate quest rewards (placeholder)"""
	return {
		"mana_crystals": randi_range(20, 100),
		"experience": randi_range(50, 200)
	}
