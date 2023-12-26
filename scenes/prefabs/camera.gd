extends Node3D

@onready var parent := get_parent() as CollisionShape3D


func _process(delta: float) -> void:
	global_position.x = parent.global_position.x
	global_position.y = parent.global_position.y
	global_position.z = parent.global_position.z

	print(parent.position)
