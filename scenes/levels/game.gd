extends Node3D


func _ready() -> void:
	SignalBus.game_paused.connect(_pause_game)
	SignalBus.game_resumed.connect(_resume_game)
	SignalBus.game_over.connect(_restart_game)

	# SignalBus.game_paused.emit()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cut"):
		_restart_game()


func _pause_game() -> void:
	get_tree().paused = true


func _resume_game() -> void:
	get_tree().paused = false


func _restart_game() -> void:
	var tree := get_tree() as SceneTree
	print(tree)
	if tree:
		tree.reload_current_scene()
