extends Resource
class_name Quest

## Quest Resource - Represents a quest in the game

@export var quest_id: String = ""
@export var quest_name: String = "Unknown Quest"
@export var description: String = ""
@export var quest_type: String = "main"  # main, side, collection, exploration
@export var objectives: Array[Dictionary] = []
@export var rewards: Dictionary = {}
@export var is_completed: bool = false
@export var is_active: bool = false

signal quest_completed(quest: Resource)
signal objective_completed(objective_index: int)

func _init():
	if quest_id == "":
		quest_id = "quest_" + str(randi())

func complete_objective(index: int):
	"""Mark an objective as completed"""
	if index >= 0 and index < objectives.size():
		objectives[index]["completed"] = true
		objective_completed.emit(index)
		check_completion()

func check_completion():
	"""Check if all objectives are completed"""
	for objective in objectives:
		if not objective.get("completed", false):
			return
	
	is_completed = true
	quest_completed.emit(self)
	
	# Notify QuestManager to complete the quest
	if QuestManager and is_active:
		QuestManager.complete_quest(self)

func get_progress() -> float:
	"""Get quest completion progress (0.0 to 1.0)"""
	if objectives.is_empty():
		return 1.0 if is_completed else 0.0
	
	var completed = 0
	for objective in objectives:
		if objective.get("completed", false):
			completed += 1
	
	return float(completed) / float(objectives.size())
