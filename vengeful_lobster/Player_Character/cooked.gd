extends AudioStreamPlayer

func delay_sound():
	await get_tree().create_timer(3).timeout
