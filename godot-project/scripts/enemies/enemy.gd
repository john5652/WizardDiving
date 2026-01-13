extends CharacterBody2D

## Base Enemy Class
## All enemies inherit from this

@export var enemy_name: String = "Enemy"
@export var max_health: int = 50
@export var speed: float = 100.0
@export var damage: int = 10
@export var experience_reward: int = 10

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

var current_health: int
var player: Node2D = null
var is_alive: bool = true

signal enemy_died(enemy: Enemy)
signal health_changed(new_health: int, max_health: int)

func _ready():
	current_health = max_health
	find_player()
	print("Enemy initialized: ", enemy_name)

func _physics_process(delta):
	if not is_alive:
		return
	
	handle_ai(delta)
	move_and_slide()

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
	
	# Visual feedback
	if sprite:
		var tween = create_tween()
		sprite.modulate = Color.RED
		tween.tween_property(sprite, "modulate", Color.WHITE, 0.2)
	
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
	
	# Give experience to player
	if player and player.has_method("gain_experience"):
		player.gain_experience(experience_reward)
	
	queue_free()

func _on_body_entered(body):
	"""Handle collision with player"""
	if body.is_in_group("player"):
		if body.has_method("take_damage"):
			body.take_damage(damage, self)
