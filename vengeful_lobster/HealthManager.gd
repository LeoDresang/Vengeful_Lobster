extends Node

const MAX_HEALTH = 3
var health = MAX_HEALTH

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_health_ui()
	$HealthBar.max_value = MAX_HEALTH
	
func update_health_ui():
	set_health_label()
	set_health_bar()
	
func set_health_label() -> void:
	$HealthLabel.text = "Health: %s" % health

func set_health_bar() -> void:
	$HealthBar.value =  health

func _input(event: InputEvent) -> void:
	print ("Input fired")
	if event.is_action_pressed("ui_accept"):
		damage()
		
func damage() -> void:
	health -= 1
	if health < 0:
		health = MAX_HEALTH
	update_health_ui()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
