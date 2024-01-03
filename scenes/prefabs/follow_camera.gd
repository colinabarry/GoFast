extends Camera3D

@onready var start_position := position

var player_speed := 0.0
var base_max_speed := 0.0


func _ready() -> void:
	SignalBus.player_velocity_changed.connect(_on_player_velocity_changed)
	SignalBus.base_max_speed_changed.connect(_on_base_max_speed_changed)


func _process(delta: float) -> void:
	var new_pos_z := remap(
		player_speed,
		0.0,
		base_max_speed,
		start_position.z,
		start_position.z - 2.5,
	)
	position.z = lerp(position.z, new_pos_z, 0.25)


func _on_player_velocity_changed(new_velocity: Vector3) -> void:
	player_speed = new_velocity.length()


func _on_base_max_speed_changed(new_base_max_speed: float) -> void:
	base_max_speed = new_base_max_speed
