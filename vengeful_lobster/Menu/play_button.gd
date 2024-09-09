extends AnimatedSprite2D

@export var transition_manager:Node = null

## The actual button object.
@onready var button:Button = $Button

func _on_button_pressed() -> void:
	transition_manager.scene_to_load = SceneNavigationGlobals.game_level
	transition_manager.scene_change()
