extends Label


func _ready() -> void:
	SignalBus.score_changed.connect(_on_score_changed)


func _on_score_changed(new_score: float) -> void:
	text = str(new_score as int)
