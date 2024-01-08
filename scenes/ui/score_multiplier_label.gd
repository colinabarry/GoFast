extends Label


func _ready() -> void:
	SignalBus.score_multiplier_changed.connect(_on_score_multiplier_changed)


func _on_score_multiplier_changed(new_score_multiplier: float) -> void:
	text = "x%.2f" % new_score_multiplier
