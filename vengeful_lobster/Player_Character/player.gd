extends CharacterBody2D

## Speed of character in pixels/sec
var speed = 175

## Animated Sprite.
@onready var sprite:AnimatedSprite2D = $ChefSprite

## Animation Player.
@onready var anim:AnimationPlayer = $ChefAnimator
@onready var anim_knife:AnimationPlayer = $KnifeAnimator

## Hit Detector.
@onready var hit_detector:Area2D = $Hit_Detector

@onready var knife:AnimatedSprite2D = $Knife

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.player = self
	sprite.set_frame(0)
	anim.play("walk")


# Called every frame. 'delta' is the elapsed time since the previous frame.S
func _process(delta: float) -> void:
	animation_process()
	Globals.player_position = position
	
	if(Input.is_action_just_pressed("swing_knife")):
		anim_knife.play("swing_knife")

func animation_process():
	look_at(get_global_mouse_position())
	if(position > get_global_mouse_position()):
		sprite.flip_v = true
	else:
		sprite.flip_v = false
	
	if(velocity):
		anim.play()
	else:
		anim.pause()

func _physics_process(delta):
	var direction:Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
