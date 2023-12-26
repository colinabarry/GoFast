extends Node

var score := 0.0
var score_multiplier := 1.0


func _process(delta: float) -> void:
	score += score_multiplier * delta
	if score == score as int:
		SignalBus.score_changed.emit(score as int)
