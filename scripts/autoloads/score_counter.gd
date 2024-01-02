extends Node

var score := 0.0
var score_multiplier := 0.0

var player_speed := 1.0
var max_speed := 1.0


func _ready() -> void:
	SignalBus.player_velocity_changed.connect(_on_player_velocity_changed)
	SignalBus.max_velocity_changed.connect(_on_max_velocity_changed)


func _process(delta: float) -> void:
	score_multiplier = remap(player_speed, 0.0, max_speed, 1.0, 2.0)
	score += score_multiplier * delta

	SignalBus.score_multiplier_changed.emit(score_multiplier)
	SignalBus.score_changed.emit(score)


func _on_player_velocity_changed(new_velocity: Vector3) -> void:
	player_speed = new_velocity.length()
	# print(player_speed)


func _on_max_velocity_changed(new_max_velocity: Vector3) -> void:
	max_speed = new_max_velocity.z
	# print(max_speed)
