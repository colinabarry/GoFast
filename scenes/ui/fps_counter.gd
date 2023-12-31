extends Label


func _process(_delta: float) -> void:
	var fps := Engine.get_frames_per_second()
	text = str(fps)
