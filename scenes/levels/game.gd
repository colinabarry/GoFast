extends Node3D


func _ready() -> void:
	SignalBus.game_paused.connect(_pause_game)
	SignalBus.game_resumed.connect(_resume_game)


func _pause_game() -> void:
	get_tree().paused = true


func _resume_game() -> void:
	get_tree().paused = false
