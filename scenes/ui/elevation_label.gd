extends Label


func _ready() -> void:
	SignalBus.player_position_changed.connect(_on_player_position_changed)


func _on_player_position_changed(new_position: Vector3) -> void:
	text = str(new_position.y as int)
