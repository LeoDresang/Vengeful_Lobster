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


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	begin_wave()

func begin_wave():
	lobsters_required = (((wave_num * 4)^2)/2) + 5
	lobsters_remaining = lobsters_required
	
	wave_big_text.visible = true
	wave_big_text.modulate.a = 1
	wave_big_text.set_text("WAVE " + str(wave_num) + " INCOMING... \n10")
	await get_tree().create_timer(1).timeout
	wave_big_text.set_text("WAVE " + str(wave_num) + " INCOMING... \n9")
	await get_tree().create_timer(1).timeout
	wave_big_text.set_text("WAVE " + str(wave_num) + " INCOMING... \n8")
	await get_tree().create_timer(1).timeout
	wave_big_text.set_text("WAVE " + str(wave_num) + " INCOMING... \n7")
	await get_tree().create_timer(1).timeout
	wave_big_text.set_text("WAVE " + str(wave_num) + " INCOMING... \n6")
	await get_tree().create_timer(1).timeout
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
			if(timer >= ((1/wave_num) + 2)):
				timer = 0
				spawner.spawn_lobster()
				lobsters_queued -= 1
		if(lobsters_remaining == 0):
			wave_active = false
			update_wave_tracker()
			wave_num += 1
			begin_wave()
