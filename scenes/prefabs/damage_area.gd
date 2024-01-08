extends Area3D

@onready var smoke_node := preload("res://scenes/prefabs/smoke_trail.tscn")

@export var damage_points := 1

var player_velocity := Vector3.ZERO


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	SignalBus.repair_collected.connect(_on_repair_collected)


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		return

	SignalBus.player_collided.emit(damage_points, name)

	var smoke_instance := smoke_node.instantiate()
	add_child(smoke_instance)

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


func _on_repair_collected() -> void:
	for child in get_children():
		if child is SmokeTrail:
			child.queue_free()
