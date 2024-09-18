extends AnimatedSprite2D

@export var transition_manager:Node = null

## The actual button object.
@onready var button:Button = $Button

func _process(delta):
	if (button.is_hovered()):
		scale.x = 13
		scale.y = 13
	else:
		scale.x = 12
		scale.y = 12
		

func _on_button_pressed() -> void:
	Globals.player_died = false
	transition_manager.scene_to_load = SceneNavigationGlobals.game_level
	transition_manager.scene_change()
	$Select.play()
