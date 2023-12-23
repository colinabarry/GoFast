extends Label

func _ready():
	SignalBus.player_journey_changed.connect(_on_player_journey_changed)


func _on_player_journey_changed(new_journey: float):
	text = str(new_journey as int)
