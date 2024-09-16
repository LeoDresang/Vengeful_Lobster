extends Node2D

@onready var main = get_parent()

var lobster_scene := preload("res://Enemies/Lobster.tscn")
var spawn_points := []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)



func spawn_lobster():
	#pick random spawn point
	var spawn = spawn_points[randi() % spawn_points.size()]
	#spawn enemy
	var temp:int = randi_range(1,100)
	if(temp == 1):
		pass
		#spawn in blue lobster
	else:
		var lobster = lobster_scene.instantiate()
		lobster.position = spawn.position
		main.add_child(lobster)
