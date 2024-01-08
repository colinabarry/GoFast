extends ColorRect

@onready var resume_button := $CenterContainer/VBoxContainer/Resume as Button
@onready var restart_button := $CenterContainer/VBoxContainer/Restart as Button
@onready var settings_button := $CenterContainer/VBoxContainer/Settings as Button
@onready var quit_button := $CenterContainer/VBoxContainer/Quit as Button

@onready var best_score_label := $CenterContainer/VBoxContainer/HBoxContainer/BestScore as Label


func _ready() -> void:
	resume_button.pressed.connect(_on_resume_pressed)
	restart_button.pressed.connect(_on_restart_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

	SignalBus.best_score_changed.connect(_on_best_score_changed)


func _on_resume_pressed() -> void:
	SignalBus.game_resumed.emit()


func _on_restart_pressed() -> void:
	SignalBus.ui_restart_pressed.emit()


func _on_settings_pressed() -> void:
	pass


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_best_score_changed(new_best_score: float) -> void:
	best_score_label.text = str(new_best_score as int)
