class_name Player extends CharacterBody3D

const mouse_look_factor = 5
const mouse_move_factor := 100

@onready var viewport: Viewport = get_viewport()
@onready var viewport_size: Vector2 = viewport.get_visible_rect().size
@onready var mesh_container: Node3D = %MeshContainer

var max_speed := 10.0
var world_speed := 0.0


func _process(delta):
	var mouse_position := viewport.get_mouse_position()
	var mouse_viewport_position := Vector3(
		remap(mouse_position.x, 0, viewport_size.x, 2, -2),
		remap(mouse_position.y, 0, viewport_size.y, 1, -1),
		0
	)
	var look_at_vector := Vector3(
		position.x + mouse_viewport_position.x * mouse_look_factor,
		position.y + mouse_viewport_position.y * mouse_look_factor,
		position.z + 2
	)

	mesh_container.look_at(look_at_vector)

	# velocity.z = world_speed
	print(world_speed)

	# velocity += mesh_container.rotation * delta  # * mouse_move_factor * mouse_viewport_position

	# velocity.x = lerp(
	# 	velocity.x, velocity.x + 1 * mouse_move_factor * delta, mouse_viewport_position.x
	# )
	# velocity.y = (lerp(
	# 	velocity.y, velocity.y + 1 * mouse_move_factor * delta, mouse_viewport_position.y
	# ))

	print("before", velocity)

	# ??

	move_and_slide()
	print("after", velocity)

	velocity.z = 0


func _on_world_speed_changed(new_speed: float) -> void:
	world_speed = new_speed
