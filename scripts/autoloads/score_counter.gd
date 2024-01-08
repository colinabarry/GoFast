extends Node

var score := 0.0
var score_multiplier := 0.0
var score_bonus := 0.0
var best_score := 0.0

var player_speed := 1.0
var base_max_speed := 1.0
var current_max_speed := 1.0


func _ready() -> void:
	SignalBus.player_velocity_changed.connect(_on_player_velocity_changed)
	SignalBus.base_max_speed_changed.connect(_on_base_max_speed_changed)
	SignalBus.current_max_speed_changed.connect(_on_current_max_speed_changed)
	SignalBus.speed_boost_collected.connect(_on_speed_boost_collected)

	SignalBus.player_died.connect(_on_player_died)


func _process(delta: float) -> void:
	score_multiplier = remap(player_speed, 0.0, base_max_speed, 0.0, 1.0)
	score_multiplier += score_bonus
	score += score_multiplier * delta

	if score > best_score:
		best_score = score
	SignalBus.best_score_changed.emit(best_score)

	SignalBus.score_multiplier_changed.emit(score_multiplier)
	SignalBus.score_changed.emit(score)


func _on_player_velocity_changed(new_velocity: Vector3) -> void:
	player_speed = new_velocity.length()


func _on_base_max_speed_changed(new_base_max_speed: float) -> void:
	base_max_speed = new_base_max_speed


func _on_current_max_speed_changed(new_current_max_speed: float) -> void:
	current_max_speed = new_current_max_speed


func _on_speed_boost_collected(boost_amount: float) -> void:
	score += boost_amount


func _on_player_died() -> void:
	score = 0.0
	score_multiplier = 0.0
	score_bonus = 0.0
