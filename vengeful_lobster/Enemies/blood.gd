extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_frame(randi_range(0,1))
	global_rotation_degrees = randi_range(0, 360)
