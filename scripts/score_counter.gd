extends Node

signal score_changed(new_score: int)

var score := 0.0
var score_multiplier := 1.0


func _process(delta):
	score += score_multiplier * delta
	if score == score as int:
		score_changed.emit(score as int)
