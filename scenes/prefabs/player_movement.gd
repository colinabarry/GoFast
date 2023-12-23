class_name Player extends CharacterBody3D

const mouse_look_factor = 15
const mouse_move_factor := 250

@onready var viewport: Viewport = get_viewport()
@onready var viewport_size: Vector2 = viewport.get_visible_rect().size
@onready var mesh_container: Node3D = %MeshContainer

# change world speed based on angle - low for steep, high for down-ish, low-ish for up-ish
static var world_speed := 200.0

var max_speed_base := 250.0
var max_speed := 250.0
var last_elevation := 0.0
var last_journey := 0.0


func _process(delta):
	var mouse_position := viewport.get_mouse_position()
	var mouse_viewport_position := Vector3(
		remap(mouse_position.x, 0, viewport_size.x, 1, -1),
		remap(mouse_position.y, 0, viewport_size.y, 1, -1),
		0
	).clamp(-Vector3.ONE, Vector3.ONE)

	var look_at_vector := Vector3(
		position.x + mouse_viewport_position.x * mouse_look_factor,
		position.y + mouse_viewport_position.y * mouse_look_factor,
		position.z + 10
	)
	mesh_container.look_at(look_at_vector)

	if abs(mouse_viewport_position.x) < 0.1:
		velocity.x = lerp(velocity.x, 0.0, remap(mouse_viewport_position.x, 0.0, 0.2, 0.05, 0.0))
	else:
		velocity.x += mouse_viewport_position.x * mouse_move_factor * 2 * delta

	var eased_mouse_viewport_y := Utility.cubic_ease_in_out(abs(mouse_viewport_position.y)) * sign(mouse_viewport_position.y) as float
	# print("normal: ", mouse_viewport_position.y, "\teased: ", eased_mouse_viewport_y)
	if abs(eased_mouse_viewport_y) < 0.1:
		velocity.y = lerp(velocity.y, 0.0, remap(eased_mouse_viewport_y, 0.0, 0.1, 0.05, 0.0))
	else:
		velocity.y += eased_mouse_viewport_y * mouse_move_factor * delta
	velocity.y += 0 * delta

	var look_at_vector_normalized = (look_at_vector - position).normalized()
	velocity.z += world_speed * (1.0 / look_at_vector_normalized.z) ** 2 * delta
	max_speed = max_speed_base + (1.0 / look_at_vector_normalized.z) ** 6 * world_speed * delta
	print("lav.z: ", look_at_vector.z)
	print("lav_norm.z: ", look_at_vector_normalized.z)
	print("1 / lav_norm.z: ", (1.0 / look_at_vector_normalized.z))
	print("max speed: ", max_speed)

	velocity = velocity.clamp(-Vector3.ONE * max_speed, Vector3.ONE * max_speed)
	move_and_slide()
	# print(velocity)


	if position.y as int != last_elevation as int:
		last_elevation = position.y
		SignalBus.player_elevation_changed.emit(position.y)

	if position.z as int != last_journey as int:
		last_journey = position.z
		SignalBus.player_journey_changed.emit(position.z)
