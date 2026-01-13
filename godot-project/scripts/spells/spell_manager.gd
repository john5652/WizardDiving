extends Node

## Spell Manager - Handles spell collection, inventory, and casting

var all_spells: Dictionary = {}  # Dictionary of all available spells
var player_spells: Array[Dictionary] = []  # Spells the player has collected

signal spell_collected(spell_data: Dictionary)
signal spell_equipped(spell_data: Dictionary, slot: int)

func _ready():
	initialize_spells()
	print("Spell Manager initialized")

func initialize_spells():
	"""Initialize default spells"""
	# Combat Spells
	register_spell({
		"id": "fireball",
		"name": "Fireball",
		"type": "combat",
		"damage": 20,
		"mana_cost": 10,
		"cooldown": 1.5,
		"description": "A basic fire spell that deals damage to enemies"
	})
	
	register_spell({
		"id": "ice_shard",
		"name": "Ice Shard",
		"type": "combat",
		"damage": 15,
		"mana_cost": 8,
		"cooldown": 1.0,
		"description": "An ice spell that can freeze enemies"
	})
	
	register_spell({
		"id": "lightning",
		"name": "Lightning Bolt",
		"type": "combat",
		"damage": 25,
		"mana_cost": 15,
		"cooldown": 2.0,
		"description": "A powerful lightning spell"
	})
	
	# Utility Spells
	register_spell({
		"id": "unlock_door",
		"name": "Unlock Door",
		"type": "utility",
		"damage": 0,
		"mana_cost": 5,
		"cooldown": 0.5,
		"description": "Unlocks magical doors"
	})
	
	register_spell({
		"id": "reveal_hidden",
		"name": "Reveal Hidden",
		"type": "utility",
		"damage": 0,
		"mana_cost": 10,
		"cooldown": 3.0,
		"description": "Reveals hidden objects and paths"
	})
	
	# Support Spells
	register_spell({
		"id": "heal",
		"name": "Heal",
		"type": "support",
		"damage": 0,
		"mana_cost": 20,
		"cooldown": 3.0,
		"description": "Restores health"
	})

func register_spell(spell_data: Dictionary):
	"""Register a spell in the spell database"""
	var spell_id = spell_data.get("id", "")
	if spell_id != "":
		all_spells[spell_id] = spell_data

func collect_spell(spell_id: String) -> bool:
	"""Collect a spell and add to player inventory"""
	if not all_spells.has(spell_id):
		push_error("Spell not found: " + spell_id)
		return false
	
	var spell_data = all_spells[spell_id].duplicate()
	
	# Check if already collected
	for spell in player_spells:
		if spell.get("id") == spell_id:
			return false  # Already have this spell
	
	player_spells.append(spell_data)
	spell_collected.emit(spell_data)
	print("Collected spell: ", spell_data.get("name"))
	return true

func get_spell(spell_id: String) -> Dictionary:
	"""Get spell data by ID"""
	if all_spells.has(spell_id):
		return all_spells[spell_id]
	return {}

func has_spell(spell_id: String) -> bool:
	"""Check if player has collected a spell"""
	for spell in player_spells:
		if spell.get("id") == spell_id:
			return true
	return false

func get_spells_by_type(type: String) -> Array[Dictionary]:
	"""Get all collected spells of a specific type"""
	var filtered = []
	for spell in player_spells:
		if spell.get("type") == type:
			filtered.append(spell)
	return filtered
