extends MeshInstance3D

var move_speed := 0.0


func _ready():
	SignalBus.player_velocity_changed.connect(on_player_velocity_changed)


func _process(delta):
	position.z = position.z - move_speed * delta
	if position.z < -mesh.size.y:
		position.z = 0


func on_player_velocity_changed(new_velocity: Vector3) -> void:
	move_speed = new_velocity.z
