extends GridMap


func _ready() -> void:
	SignalBus.player_position_changed.connect(_on_player_position_changed)


func _on_player_position_changed(new_position: Vector3) -> void:
	print("\non_pos_changed: ")
	print(new_position.z as int)
	print(new_position.z as int % 1000)
	if new_position.z as int % 1000 == 0:
		print("move it out!")
		position.z = new_position.z
