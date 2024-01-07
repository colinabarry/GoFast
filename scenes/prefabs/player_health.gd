extends Node3D


func _ready() -> void:
	SignalBus.player_died.connect(_on_player_died)


func _on_player_died() -> void:
	Game._restart_game()
