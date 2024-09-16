extends Node

@export var spawner:Node2D = null

var wave_num:int = 1
var lobsters_remaining:int
var lobsters_required:int
var lobsters_queued:int

var timer:float = 0.0

var wave_big_text_fade:bool = false

var wave_active:bool = false

@onready var wave_big_text:Label = $WaveBigText
@onready var wave_tracker:Label = $WaveTracker
@onready var lobster_tracker:Label = $LobsterTracker
@onready var cooked:Sprite2D = $Control/Cooked

@export var health_manager:Node




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.cooked.connect(cooked_screen)
	cooked.visible = false
	cooked.modulate.a = 0
	begin_wave()
	Globals.lobster_killed.connect(lobster_killed)

func begin_wave():
	lobsters_required = (((wave_num * 6)^2)/2) + 10
	lobsters_remaining = lobsters_required
	
	wave_big_text.visible = true
	wave_big_text.modulate.a = 1
	wave_big_text.set_text("WAVE " + str(wave_num) + " INCOMING... \n5")
	await get_tree().create_timer(1).timeout
	wave_big_text.set_text("WAVE " + str(wave_num) + " INCOMING... \n4")
	await get_tree().create_timer(1).timeout
	wave_big_text.set_text("WAVE " + str(wave_num) + " INCOMING... \n3")
	await get_tree().create_timer(1).timeout
	wave_big_text.set_text("WAVE " + str(wave_num) + " INCOMING... \n2")
	await get_tree().create_timer(1).timeout
	wave_big_text.set_text("WAVE " + str(wave_num) + " INCOMING... \n1")
	await get_tree().create_timer(1).timeout
	wave_big_text.set_text("WAVE " + str(wave_num) + " INCOMING... \nNOW!")
	wave_big_text_fade = true
	lobsters_queued = lobsters_required
	update_lobster_tracker()
	
	wave_active = true



func update_lobster_tracker():
	lobster_tracker.set_text("LOBSTERS\nREMAINING\n" + str(lobsters_remaining))


func update_wave_tracker():
	wave_tracker.set_text("WAVES\nSURVIVED\n" + str(wave_num))


func lobster_killed():
	lobsters_remaining -= 1
	update_lobster_tracker()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(wave_big_text_fade):
		if(wave_big_text.modulate.a > 0):
			wave_big_text.modulate.a -= delta
		else:
			wave_big_text.visible = false
			wave_big_text_fade = false
	if(wave_active):
		if(lobsters_queued > 0):
			timer += delta
			if(timer >= ((1/wave_num) + 0.8)):
				timer = 0
				spawner.spawn_lobster()
				lobsters_queued -= 1
		if(lobsters_remaining == 0):
			wave_active = false
			update_wave_tracker()
			wave_num += 1
			health_manager.health = health_manager.MAX_HEALTH
			health_manager.update_health_ui()
			begin_wave()
			

func cooked_screen():
	await get_tree().create_timer(4).timeout
	cooked.visible = true
	while(cooked.modulate.a < 1):
		cooked.modulate.a += 0.006
		await get_tree().create_timer(0.01).timeout

		
