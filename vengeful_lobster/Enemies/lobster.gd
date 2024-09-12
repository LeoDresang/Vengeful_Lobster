extends CharacterBody2D

## Animated Sprite.
@onready var sprite:AnimatedSprite2D = $AnimatedSprite2D

## Animation Player.
@onready var anim:AnimationPlayer = $AnimationPlayer

## NavigationAgent2D
@onready var navigation_agent_2d = $NavigationAgent2D

var speed : int = 150
var acceleration = 7
var screen_center:Vector2
var target_direction 

func _ready() -> void:
	sprite.set_frame(0)
	anim.play("walk")

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
	var direction = Vector2.ZERO
	direction = (navigation_agent_2d.get_next_path_position()) - global_position
	
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, acceleration * delta)
	
	move_and_slide()

func _on_damage_area_area_entered(area: Area2D) -> void:
	if (area.get_parent() == Globals.player):
		print("Player hit!")
		


func _on_timer_timeout():
	navigation_agent_2d.target_location = Globals.player_position
