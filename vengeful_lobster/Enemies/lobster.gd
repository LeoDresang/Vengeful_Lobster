extends CharacterBody2D

## Animated Sprite.
@onready var sprite:AnimatedSprite2D = $AnimatedSprite2D

## Animation Player.
@onready var anim:AnimationPlayer = $AnimationPlayer


var entered : bool
var speed : int = 120
var direction : Vector2
var screen_center:Vector2

func _ready():
	speed += randi_range(-10,10)
	sprite.set_frame(0)
	anim.play("walk")

func _process(delta: float) -> void:
	screen_center = get_viewport_rect().get_center()
	animation_process()
	

func animation_process():
	look_at(Globals.player.position)
	
	if(velocity):
		anim.play()
	else:
		anim.pause()

func _physics_process(delta):
	velocity = (Globals.player.position - position).normalized() * speed
	move_and_slide()
	
