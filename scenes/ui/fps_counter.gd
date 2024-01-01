extends Label

var fps_sum := 0.0
var average_fps := 0.0


func _process(_delta: float) -> void:
	var fps := Engine.get_frames_per_second()

	fps_sum += fps
	var frame_count := Engine.get_frames_drawn()
	average_fps = fps_sum / frame_count
	text = str(fps) + " (" + str(average_fps as int) + " avg)"
