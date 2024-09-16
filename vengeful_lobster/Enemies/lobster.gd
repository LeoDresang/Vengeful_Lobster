extends CharacterBody2D

@onready var main = get_parent()

var blood_scene := preload("uid://chbhuyn2gh6p5")

## Animated Sprite.
@onready var sprite:AnimatedSprite2D = $AnimatedSprite2D

## Animation Player.
@onready var anim:AnimationPlayer = $AnimationPlayer

## NavigationAgent2D
@onready var navigation_agent_2d = $NavigationAgent2D

var speed : int = 90
var acceleration = 7
var screen_center:Vector2
var target_direction 

var attacking: bool = false
var dying: bool = false

func _ready() -> void:
	sprite.set_frame(0)
	anim.play("walk")

func _process(delta: float) -> void:
	screen_center = get_viewport_rect().get_center()
	animation_process()
	
	if (Globals.player.swinging_knife):
		if($Damage_Area.get_overlapping_areas()):
			for area in $Damage_Area.get_overlapping_areas():
				if (area == Globals.knife_area):
					dying = true
		
	
	
	

func animation_process():
	if(!dying):
		look_at(Globals.player_position)
		
	if(dying):
		anim.play("death")
		await get_tree().create_timer(anim.current_animation_length).timeout
		Globals.lobster_killed_signal()
		var blood = blood_scene.instantiate()
		blood.position = position
		main.add_child(blood)
		self.queue_free()
	elif(attacking):
		anim.play("attacking")
		await get_tree().create_timer(anim.current_animation_length).timeout
		attacking = false
		anim.play("walk")
	else:
		if(velocity):
			anim.play()
		else:
			anim.pause()

func _physics_process(delta):
	var direction = Vector2.ZERO
	direction = (navigation_agent_2d.get_next_path_position()) - global_position
	
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, acceleration * delta)
	if(!dying || !attacking):
		move_and_slide()


func _on_timer_timeout():
	navigation_agent_2d.target_location = Globals.player_position
