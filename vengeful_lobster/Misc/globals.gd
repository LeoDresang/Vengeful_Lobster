extends Node

var player:CharacterBody2D = null
var player_position:Vector2 = Vector2(0,0)
var knife_area:Area2D
var player_died = false

signal lobster_killed

func lobster_killed_signal():
	lobster_killed.emit()
	
func player_death():
	player_died = true
	await get_tree().create_timer(10).timeout
	get_tree().change_scene_to_packed(load(SceneNavigationGlobals.start_menu))
