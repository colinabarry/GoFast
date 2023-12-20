extends MeshInstance3D

var move_speed := 10


func _process(delta):
	position.z = position.z - move_speed * delta
	if position.z < -mesh.size.y:
		position.z = 0
