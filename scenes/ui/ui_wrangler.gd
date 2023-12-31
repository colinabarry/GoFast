extends CanvasLayer

@onready var pause_menu := $PauseMenu as ColorRect

var game_paused := false


func _ready() -> void:
	SignalBus.game_paused.connect(_on_game_paused)
	SignalBus.game_resumed.connect(_on_game_resumed)


func _process(_delta: float) -> void:
	if game_paused:
		if Input.is_action_just_pressed("ui_cancel"):
			SignalBus.game_resumed.emit()
	else:
		if Input.is_action_just_pressed("ui_pause"):
			SignalBus.game_paused.emit()


func _on_game_paused() -> void:
	pause_menu.visible = true
	game_paused = true


func _on_game_resumed() -> void:
	pause_menu.visible = false
	game_paused = false
