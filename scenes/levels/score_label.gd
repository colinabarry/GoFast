extends Label


func _ready():
	ScoreCounter.score_changed.connect(on_score_changed)


func on_score_changed(new_score: int):
	text = str(new_score)
