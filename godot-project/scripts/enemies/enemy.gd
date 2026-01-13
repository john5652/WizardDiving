extends CharacterBody2D

## Base Enemy Class
## All enemies inherit from this

@export var enemy_name: String = "Enemy"
@export var max_health: int = 50
@export var speed: float = 100.0
@export var damage: int = 10
@export var experience_reward: int = 10

@onready var visual: Sprite2D = $Visual
@onready var collision: CollisionShape2D = $CollisionShape2D

var current_health: int
var player: Node2D = null
var is_alive: bool = true

signal enemy_died(enemy: CharacterBody2D)
signal health_changed(new_health: int, max_health: int)

func _ready():
	current_health = max_health
	find_player()
	add_to_group("enemies")
	
	# Load goblin sprite texture
	if visual:
		var texture_path = "res://assets/sprites/characters/enemies/pixelantasy_goblin/PNG/goblin_2.png"
		if ResourceLoader.exists(texture_path):
			visual.texture = load(texture_path)
			visual.scale = Vector2(0.4, 0.4)  # Scale down from 64-96px
		else:
			print("Warning: Goblin texture not found at: ", texture_path)
	
	print("Enemy initialized: ", enemy_name)

var damage_timer: float = 0.0
var damage_cooldown: float = 0.5  # Damage player every 0.5 seconds

func _physics_process(delta):
	if not is_alive:
		return
	
	handle_ai(delta)
	
	# Check if touching player for damage
	if player:
		var distance = global_position.distance_to(player.global_position)
		if distance < 40:  # Close enough to damage
			damage_timer += delta
			if damage_timer >= damage_cooldown:
				if player.has_method("take_damage"):
					player.take_damage(damage)  # Only pass damage amount
					damage_timer = 0.0
	
	# Move but allow player to push through
	move_and_slide()
	
	# If colliding with player, move enemy away to prevent blocking
	if player:
		var distance = global_position.distance_to(player.global_position)
		if distance < 35:  # Too close, push away
			var push_dir = (global_position - player.global_position).normalized()
			if push_dir.length() > 0:
				global_position += push_dir * 10  # Push enemy away

func find_player():
	"""Find the player in the scene"""
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]

func handle_ai(delta):
	"""Override in child classes for specific AI behavior"""
	# Basic: Move towards player if found
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

func take_damage(amount: int, source: Node2D = null):
	"""Take damage and check for death"""
	if not is_alive:
		return
	
	current_health -= amount
	current_health = max(0, current_health)
	health_changed.emit(current_health, max_health)
	
	# Visual feedback (flash red when hit)
	if visual:
		var tween = create_tween()
		visual.modulate = Color(1, 0.3, 0.3, 1)
		tween.tween_property(visual, "modulate", Color.WHITE, 0.2)
	
	if current_health <= 0:
		die()

func die():
	"""Handle enemy death"""
	if not is_alive:
		return
	
	is_alive = false
	enemy_died.emit(self)
	
	# TODO: Add death animation, drop items, etc.
	print("Enemy died: ", enemy_name)
	
	# Update quest progress for enemy defeat
	update_quest_progress("combat")
	
	# Give experience to player
	if player and player.has_method("gain_experience"):
		player.gain_experience(experience_reward)
	
	queue_free()

func update_quest_progress(quest_type: String):
	"""Update quest progress based on action type"""
	for quest in QuestManager.active_quests:
		for i in range(quest.objectives.size()):
			var objective = quest.objectives[i]
			if objective.get("type", "") == quest_type and not objective.get("completed", false):
				quest.complete_objective(i)
				break

func apply_knockback(force: Vector2):
	"""Apply knockback force (for when player pushes enemy)"""
	global_position += force * get_physics_process_delta_time()

func _on_body_entered(body):
	"""Handle collision with player - use Area2D for this instead"""
	# This is for Area2D collision detection
	# For CharacterBody2D, we handle damage in _physics_process
	pass
