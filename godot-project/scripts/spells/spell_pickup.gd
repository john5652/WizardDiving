extends Area2D

## Spell Pickup - Collectible spell item in the world

@export var spell_id: String = "fireball"
@export var auto_collect: bool = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

var collected: bool = false

func _ready():
	# Set up collision detection
	body_entered.connect(_on_body_entered)
	
	# Visual feedback - make it glow/pulse
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(sprite, "modulate", Color(1.5, 1.5, 1.5, 1.0), 0.5)
	tween.tween_property(sprite, "modulate", Color.WHITE, 0.5)
	
	print("Spell pickup created: ", spell_id)

func _on_body_entered(body):
	"""Called when player enters the pickup area"""
	if collected:
		return
	
	if body.has_method("collect_spell"):
		collected = true
		var spell_data = SpellManager.get_spell(spell_id)
		if not spell_data.is_empty():
			body.collect_spell(spell_data)
			SpellManager.collect_spell(spell_id)
		collect_effect()
		queue_free()

func collect_effect():
	"""Visual/audio effect when collected"""
	# TODO: Add particle effect, sound, etc.
	print("Spell collected: ", spell_id)
