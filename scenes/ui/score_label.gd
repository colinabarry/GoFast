extends Label

var score := 0.0
var score_multiplier := 0.0


func _ready() -> void:
	SignalBus.score_changed.connect(_on_score_changed)
	SignalBus.score_multiplier_changed.connect(_on_score_multiplier_changed)


func _physics_process(_delta: float) -> void:
	text = "%s (x%.2f)" % [score as int, score_multiplier]


func _on_score_changed(new_score: float) -> void:
	score = new_score


func _on_score_multiplier_changed(new_score_multiplier: float) -> void:
	score_multiplier = new_score_multiplier
