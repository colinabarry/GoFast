extends Area3D

var chunk := load("res://scenes/prefabs/environment/chunk.tscn")


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		SignalBus.tube_area_entered.emit()

		var new_chunk: Area3D = chunk.instantiate()
		new_chunk.position.z = position.z + 256  # FIXME: BAD MAGIC NUMBER FROM MESH Y SIZE
		get_parent().add_child(new_chunk)
