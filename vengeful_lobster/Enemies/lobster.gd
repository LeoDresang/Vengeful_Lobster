extends CharacterBody2D

## Animated Sprite.
@onready var sprite:AnimatedSprite2D = $AnimatedSprite2D

## Animation Player.
@onready var anim:AnimationPlayer = $AnimationPlayer

## RayCast2D
@onready var ray_cast_2d = $RayCast2D

var speed : int = 120
var direction : Vector2
var screen_center:Vector2

func _ready():
	speed += randi_range(-10,10)
	sprite.set_frame(0)
	anim.play("walk")
	ray_cast_2d.enabled = true

func _process(delta: float) -> void:
	screen_center = get_viewport_rect().get_center()
	animation_process()
	
	
	

func animation_process():
	look_at(Globals.player_position)
	
	if(velocity):
		anim.play()
	else:
		anim.pause()

func _physics_process(delta):
	var direction_to_player = (Globals.player_position - global_position).normalized()

	# Calculate movement direction
	var target_direction = direction_to_player

	# Obstacle avoidance
	if ray_cast_2d.is_colliding():
		var collision_normal = ray_cast_2d.get_collision_normal()
		# Adjust direction to avoid the obstacle
		target_direction = direction_to_player.rotated(collision_normal.angle() + 20)  # Rotate to avoid obstacle
	# Apply movement
	velocity = target_direction * speed
	# Optional: Slightly adjust velocity if moving too fast and getting stuck
	if velocity.length() > speed:
		velocity = velocity.normalized() * speed
	move_and_slide()

	# Smoothly rotate to align with movement direction
	rotation = lerp_angle(rotation, velocity.angle(), 0.2)
	


func _on_damage_area_area_entered(area: Area2D) -> void:
	if (area.get_parent() == Globals.player):
		print("Player hit!")
		
