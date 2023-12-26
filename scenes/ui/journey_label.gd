extends Label


func _ready() -> void:
	SignalBus.player_journey_changed.connect(_on_player_journey_changed)


func _on_player_journey_changed(new_journey: float) -> void:
	text = str(new_journey as int)
