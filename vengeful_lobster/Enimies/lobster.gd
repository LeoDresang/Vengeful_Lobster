extends CharacterBody2D

var entered : bool
var speed : int = 1
var direction : Vector2

func _ready():
	var screen_rect = get_viewport_rect()
	#print(screen_rect)
	entered = false
	#pick a direction to the entrance
	var dist:Vector2 = screen_rect.get_center() - position
	#check if need to move horizontally or vertically
	if abs(dist.x) > abs(dist.y):
		# move horizontally
		direction.x = dist.x
		direction.y = 0
	else:
		#move vertically
		direction.x = 0
		direction.y = dist.y

func _physics_process(delta):
	velocity = direction * speed
	move_and_slide()
	print(position)
