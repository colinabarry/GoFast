extends ColorRect

@onready var resume_button := $CenterContainer/VBoxContainer/Resume
@onready var settings_button := $CenterContainer/VBoxContainer/Settings
@onready var quit_button := $CenterContainer/VBoxContainer/Quit


func _ready() -> void:
	resume_button.pressed.connect(_on_resume_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	quit_button.pressed.connect(_on_quit_pressed)


func _on_resume_pressed() -> void:
	SignalBus.game_resumed.emit()


func _on_settings_pressed() -> void:
	pass


func _on_quit_pressed() -> void:
	get_tree().quit()
