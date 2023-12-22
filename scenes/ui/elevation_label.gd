extends Label

func _ready():
	SignalBus.player_elevation_changed.connect(_on_player_elevation_changed)


func _on_player_elevation_changed(new_elevation: float):
	text = str(new_elevation as int)
