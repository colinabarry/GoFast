extends Node3D

@export_range(0.0, 10.0) var rotation_speed_degrees := 1.0


func _process(delta: float) -> void:
	rotation_degrees.x += rotation_speed_degrees * delta
