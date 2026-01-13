extends "res://scripts/enemies/enemy.gd"

## Bat Enemy - Flying enemy with swoop attack behavior
## Extends base enemy class with flying movement patterns

@export var swoop_distance: float = 150.0  # Distance to swoop at player
@export var hover_height: float = 50.0  # Height variation for hovering
@export var swoop_cooldown: float = 3.0  # Time between swoops

var swoop_timer: float = 0.0
var is_swooping: bool = false
var base_y: float = 0.0  # Base Y position for hovering
var hover_offset: float = 0.0
var hover_speed: float = 2.0  # Speed of hover oscillation

func _ready():
	# Set bat-specific stats
	max_health = 20  # Lower health than goblin
	speed = 120.0  # Faster than goblin
	damage = 4  # Less damage but faster attacks
	experience_reward = 10
	
	# Store base Y position for hovering
	base_y = global_position.y
	
	# Set up bat animations
	if visual:
		setup_bat_animations()
		visual.scale = Vector2(2.0, 2.0)  # Scale for visibility
	
	# Call parent _ready after setting stats
	super._ready()

func setup_bat_animations():
	"""Set up bat sprite animations from spritesheet"""
	if not visual:
		return
	
	var sprite_frames = SpriteFrames.new()
	sprite_frames.remove_animation("default")
	
	var bat_sprite_path = "res://assets/sprites/environment/dungeons/characters/bat_enemy.png"
	
	if ResourceLoader.exists(bat_sprite_path):
		var bat_texture = load(bat_sprite_path) as Texture2D
		if bat_texture:
			# The bat sprite is a 10-frame spritesheet
			# Assuming frames are arranged horizontally
			var frame_width = bat_texture.get_width() / 10
			var frame_height = bat_texture.get_height()
			
			# Create fly animation (all 10 frames)
			sprite_frames.add_animation("fly")
			sprite_frames.set_animation_speed("fly", 10.0)  # Fast wing flapping
			
			# Extract frames from spritesheet
			for i in range(10):
				var atlas = AtlasTexture.new()
				atlas.atlas = bat_texture
				atlas.region = Rect2(i * frame_width, 0, frame_width, frame_height)
				sprite_frames.add_frame("fly", atlas)
			
			# Use fly animation for both idle and movement (bats are always flying)
			sprite_frames.add_animation("idle")
			sprite_frames.set_animation_speed("idle", 10.0)
			for i in range(10):
				var atlas = AtlasTexture.new()
				atlas.atlas = bat_texture
				atlas.region = Rect2(i * frame_width, 0, frame_width, frame_height)
				sprite_frames.add_frame("idle", atlas)
			
			visual.sprite_frames = sprite_frames
			visual.play("fly")
		else:
			print("ERROR: Could not load bat texture")
	else:
		print("WARNING: Bat sprite not found at: ", bat_sprite_path)
		# Fallback: use goblin animations
		setup_goblin_animations()

func handle_ai(delta):
	"""Flying bat AI - hovers and swoops at player"""
	if not player:
		# Hover in place when no player
		hover_offset += hover_speed * delta
		global_position.y = base_y + sin(hover_offset) * hover_height
		velocity = Vector2.ZERO
		if visual and visual.sprite_frames and visual.sprite_frames.has_animation("fly"):
			visual.play("fly")
		return
	
	# Update swoop timer
	swoop_timer += delta
	
	var distance_to_player = global_position.distance_to(player.global_position)
	var direction_to_player = (player.global_position - global_position).normalized()
	
	# Swoop attack when close enough and cooldown is ready
	if distance_to_player < swoop_distance and swoop_timer >= swoop_cooldown and not is_swooping:
		is_swooping = true
		swoop_timer = 0.0
	
	# Swoop behavior: fast movement towards player
	if is_swooping:
		velocity = direction_to_player * (speed * 1.5)  # 50% faster during swoop
		
		# End swoop when close to player or after time
		if distance_to_player < 30 or swoop_timer > 1.0:
			is_swooping = false
			swoop_timer = 0.0
	else:
		# Normal flying: move towards player with hover
		velocity = direction_to_player * speed
		
		# Add vertical hover oscillation
		hover_offset += hover_speed * delta
		var hover_y = sin(hover_offset) * (hover_height * 0.5)
		velocity.y += hover_y
	
	# Flip sprite based on movement direction
	if visual and direction_to_player.x != 0:
		visual.scale.x = sign(direction_to_player.x) * abs(visual.scale.x)
	
	# Always play fly animation
	if visual and visual.sprite_frames and visual.sprite_frames.has_animation("fly"):
		visual.play("fly")

func _physics_process(delta):
	"""Override to add flying behavior"""
	# Call parent physics process
	super._physics_process(delta)
	
	# Bats can move in Y axis (flying)
	# The base class move_and_slide() handles this
