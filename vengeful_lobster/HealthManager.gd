extends Node

const MAX_HEALTH = 3
var health = MAX_HEALTH

@onready var h_bar:AnimatedSprite2D = $Control/DailylilaHealthbarV1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_health_ui()
	
func update_health_ui():
	h_bar.set_frame(health)
	
func damage() -> void:
	health -= 1
	update_health_ui()
	if health < 1:
		Globals.player_death()
