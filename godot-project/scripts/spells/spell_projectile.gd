extends Area2D

## Spell Projectile - Visual representation of a cast spell

@export var speed: float = 400.0
@export var damage: int = 10
@export var lifetime: float = 2.0

var direction: Vector2 = Vector2.RIGHT
var spell_type: String = "fireball"

@onready var visual: ColorRect = $Visual
@onready var collision: CollisionShape2D = $CollisionShape2D

func _ready():
	# Set visual based on spell type
	if visual:
		match spell_type:
			"fireball":
				visual.color = Color(1, 0.3, 0.1, 1)
				if visual.get_child_count() > 0:
					var glow = visual.get_child(0)
					if glow is ColorRect:
						glow.color = Color(1, 0.8, 0.3, 0.7)
			"ice_shard":
				visual.color = Color(0.2, 0.8, 1, 1)
				if visual.get_child_count() > 0:
					var glow = visual.get_child(0)
					if glow is ColorRect:
						glow.color = Color(0.4, 0.9, 1, 0.7)
			"lightning":
				visual.color = Color(0.8, 0.8, 0.2, 1)
				if visual.get_child_count() > 0:
					var glow = visual.get_child(0)
					if glow is ColorRect:
						glow.color = Color(1, 1, 0.4, 0.7)
			_:
				visual.color = Color.WHITE
	
	# Auto-destroy after lifetime
	var timer = get_tree().create_timer(lifetime)
	timer.timeout.connect(queue_free)
	
	# Connect collision
	body_entered.connect(_on_body_entered)
	
	# Add to projectiles group for easy management
	add_to_group("projectiles")

func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	"""Handle collision with enemies"""
	# Don't hit player or other projectiles
	if body.is_in_group("player") or body.is_in_group("projectiles"):
		return
	
	# Don't hit walls/doors
	if body is StaticBody2D and not body.has_method("take_damage"):
		queue_free()
		return
	
	# Hit enemies (anything with take_damage that's not player)
	if body.has_method("take_damage") and not body.is_in_group("player"):
		print("Projectile hit: ", body.name, " for ", damage, " damage")
		body.take_damage(damage, self)
		queue_free()
