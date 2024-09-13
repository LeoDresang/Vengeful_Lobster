extends CharacterBody2D

## Speed of character in pixels/sec
var speed = 125

## Animated Sprite.
@onready var sprite:AnimatedSprite2D = $ChefSprite

## Animation Player.
@onready var anim:AnimationPlayer = $ChefAnimator
@onready var anim_knife:AnimationPlayer = $KnifeAnimator

## Hit Detector.
@onready var hit_detector:Area2D = $Hit_Detector

@onready var knife_damage:Area2D = $KnifeDamage

@onready var knife:AnimatedSprite2D = $Knife

@export var health_manager:Node

var invincible:bool = false

var swinging_knife:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.player = self
	Globals.knife_area = knife_damage
	sprite.set_frame(0)
	anim.play("walk")


# Called every frame. 'delta' is the elapsed time since the previous frame.S
func _process(delta: float) -> void:
	if(!Globals.player_died):
		animation_process()
		Globals.player_position = position
		
		if(!invincible):
			if(hit_detector.get_overlapping_areas()):
				for area in hit_detector.get_overlapping_areas():
					if (area.get_parent().is_in_group("Lobster")):
						invincible = true
						anim.play("damaged")
						health_manager.damage()
						await get_tree().create_timer(2).timeout
						invincible = false
						anim.play("walk")

						
		
		if(!anim_knife.is_playing() and Input.is_action_just_pressed("swing_knife")):
			swinging_knife = true
			anim_knife.play("swing_knife")
			await get_tree().create_timer(anim_knife.current_animation_length -0.15).timeout
			swinging_knife = false
			await get_tree().create_timer(0.15).timeout
			knife.set_frame(0)
	else:
		sprite.rotation = 0
		rotation = 0
		knife.visible = false
		if(sprite.get_frame() != 8):
			sprite.set_frame(8)
			


func animation_process():
	if(!swinging_knife):
		look_at(get_global_mouse_position())
		if(position > get_global_mouse_position()):
			sprite.flip_v = true
		else:
			sprite.flip_v = false
	
	if(!invincible):
		if(velocity):
			anim.play()
		else:
			anim.pause()
	else:
		anim.play()

func _physics_process(delta):
	if(!Globals.player_died):
		var direction:Vector2 = Input.get_vector("left", "right", "up", "down")
		velocity = direction * speed
		move_and_slide()
