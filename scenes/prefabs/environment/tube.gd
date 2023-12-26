extends Area3D

# func _ready():
# 	SignalBus.tube_area_entered.connect(_on_tube_area_entered)

# func _on_tube_area_entered():
# 	var new_tube := duplicate()
# 	new_tube.position.z += 300 * 3  # FIXME: BAD MAGIC NUMBER FROM MESH Y SIZE
# 	get_parent().add_child(new_tube)


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		SignalBus.tube_area_entered.emit()

		var new_tube := duplicate()
		new_tube.position.z += 2000  # FIXME: BAD MAGIC NUMBER FROM MESH Y SIZE
		get_parent().add_child(new_tube)
