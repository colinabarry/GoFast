extends Area3D

@onready var smoke_node := preload("res://scenes/prefabs/smoke_trail.tscn")

@export var damage_points := 1

var player_velocity := Vector3.ZERO


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(_body: Node3D) -> void:
	SignalBus.player_collided.emit(damage_points, position)
	var new_smoke := smoke_node.instantiate()
	add_child(new_smoke)

	# # nose
	# if is_zero_approx(position.x):
	# 	SignalBus.player_collided.emit(damage_points, vec_from_body)

	# # left wing
	# if position.x < 0:
	# 	SignalBus.player_collided.emit(damage_points, vec_from_body)

	# # right wing
	# else:
	# 	SignalBus.player_collided.emit(damage_points, vec_from_body)


func _on_player_velocity_changed(new_velocity: Vector3) -> void:
	player_velocity = new_velocity
