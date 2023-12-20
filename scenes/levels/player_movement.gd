extends CharacterBody3D

const mouse_look_factor = 5
const mouse_move_factor := 10

var viewport: Viewport
var viewport_size: Vector2


func _ready():
	viewport = get_viewport()
	viewport_size = viewport.get_visible_rect().size


func _process(delta):
	var mouse_position := viewport.get_mouse_position()

	var mouse_viewport_position := Vector2(
		remap(mouse_position.x, 0, viewport_size.x, 2, -2),
		remap(mouse_position.y, 0, viewport_size.y, 1, -1),
	)
	print(mouse_position)
	print("\t", mouse_viewport_position)

	position.x = lerp(
		position.x, position.x + 1 * mouse_move_factor * delta, mouse_viewport_position.x
	)
	position.y = lerp(
		position.y, position.y + 1 * mouse_move_factor * delta, mouse_viewport_position.y
	)
	# move_and_collide(
	# Vector3(
	# position.x + 1 * mouse_move_factor * mouse_viewport_position.x * delta,
	# position.y + 1 * mouse_move_factor * mouse_viewport_position.y * delta,
	# position.z
	# )
	# )

	%MeshContainer.look_at(
		Vector3(
			position.x + mouse_viewport_position.x * mouse_look_factor,
			position.y + mouse_viewport_position.y * mouse_look_factor,
			position.z + 2
		)
	)
