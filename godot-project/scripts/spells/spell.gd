extends Node2D

## Base Spell Class
## All spells inherit from this

@export var spell_name: String = "Unknown Spell"
@export var spell_type: String = "combat"  # combat, utility, support
@export var damage: int = 10
@export var mana_cost: int = 5
@export var cooldown: float = 1.0
@export var cast_time: float = 0.2
@export var spell_icon: Texture2D

var current_cooldown: float = 0.0
var is_ready: bool = true

signal spell_cast(spell: Spell)
signal spell_ready

func _ready():
	print("Spell initialized: ", spell_name)

func _process(delta):
	if current_cooldown > 0:
		current_cooldown -= delta
		if current_cooldown <= 0:
			current_cooldown = 0
			is_ready = true
			spell_ready.emit()

func cast(caster: Node2D, target_position: Vector2) -> bool:
	"""Cast the spell. Returns true if successful."""
	if not is_ready:
		return false
	
	is_ready = false
	current_cooldown = cooldown
	spell_cast.emit(self)
	
	# Override in child classes for specific spell behavior
	execute_spell(caster, target_position)
	
	return true

func execute_spell(caster: Node2D, target_position: Vector2):
	"""Override this in child classes to implement spell behavior"""
	pass

func get_spell_data() -> Dictionary:
	"""Get spell data as dictionary for saving/loading"""
	return {
		"name": spell_name,
		"type": spell_type,
		"damage": damage,
		"mana_cost": mana_cost,
		"cooldown": cooldown
	}
