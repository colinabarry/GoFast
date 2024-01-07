class_name Player extends CharacterBody3D

const mouse_look_factor = 15
const mouse_move_factor := 25

@onready var viewport := get_viewport() as Viewport
@onready var viewport_size := viewport.get_visible_rect().size as Vector2
@onready var mesh_container := %MeshContainer as Node3D

@onready var nose_marker := $MeshContainer/ShipMesh/NoseMarker as Marker3D

var world_speed := 5.0

var base_max_speed := 50.0
var current_max_speed := base_max_speed

var last_elevation := 0.0
var last_journey := 0.0
var last_velocity := Vector3.ZERO
var last_position := Vector3.ZERO

var mouse_pos := Vector2.ZERO
var mouse_pos_norm := Vector3.ZERO
var look_at_vec := Vector3.ZERO
var push_vector := Vector3.ZERO

var can_collide := true
var is_boosting := false
var is_alive := true


func _ready() -> void:
	SignalBus.speed_boost_collected.connect(_on_speed_boost_collected)
	SignalBus.player_died.connect(_on_player_died)


func _process(delta: float) -> void:
	if !is_alive:
		return

	mouse_pos = viewport.get_mouse_position()
	mouse_pos_norm = _get_mouse_pos_norm()
	look_at_vec = _get_look_at_vec()

	#

	mesh_container.look_at(look_at_vec + position + Vector3(0, 2, 0))

	_set_push_vector_and_implement_dead_zone(delta)

	velocity += push_vector
	last_velocity = velocity

	var collision := move_and_collide(velocity * delta)
	if collision:
		_handle_collision(collision)

	_clamp_velocity()

	#

	_emit_signals()


func _get_mouse_pos_norm() -> Vector3:
	return (
		Vector3(
			remap(mouse_pos.x, 0, viewport_size.x, 1, -1),
			remap(mouse_pos.y, 0, viewport_size.y, 1, -1),
			0
		)
		. clamp(-Vector3.ONE, Vector3.ONE)
	)


func _get_look_at_vec() -> Vector3:
	return (
		Vector3(
			position.x + mouse_pos_norm.x * mouse_look_factor,
			position.y + mouse_pos_norm.y * mouse_look_factor,
			position.z + 10
		)
		- position
	)


# TODO: Refactor this for clarity
## This function sets the push vector based on look at vec, and also lerps velocity x and y to 0 when mouse is in the "dead zone"
func _set_push_vector_and_implement_dead_zone(delta: float) -> void:
	push_vector = look_at_vec.normalized()
	push_vector.x *= mouse_move_factor * 1.25 * delta
	push_vector.y *= mouse_move_factor * delta
	push_vector.z *= world_speed * delta

	if abs(mouse_pos_norm.x) <= 0.1:
		push_vector.x = lerp(push_vector.x, 0.0, 0.5)
		velocity.x = lerp(velocity.x, 0.0, 0.05)

	if abs(mouse_pos_norm.y) <= 0.1:
		push_vector.y = lerp(push_vector.y, 0.0, 0.5)
		velocity.y = lerp(velocity.y, 0.0, 0.05)


func _handle_collision(collision: KinematicCollision3D) -> void:
	if can_collide and collision:
		# SignalBus.player_collided.emit()
		can_collide = false

		var vec_to_collision := collision.get_position() - position
		velocity -= vec_to_collision.normalized() * 15
		velocity.z = last_velocity.z / 2

		# await get_tree().create_timer(0.5).timeout
		can_collide = true


func _emit_signals() -> void:
	if !position.is_equal_approx(last_position):
		last_position = position
		SignalBus.player_position_changed.emit(position)

	SignalBus.player_velocity_changed.emit(velocity)
	# SignalBus.max_velocity_changed.emit(Vector3.ONE * max_vel)
	SignalBus.base_max_speed_changed.emit(base_max_speed)
	SignalBus.current_max_speed_changed.emit(current_max_speed)


# func _handle_max_speed() -> void:
# 	if current_max_speed > base_max_speed:
# 		current_max_speed = lerp(current_max_speed, base_max_speed, 1 * get_process_delta_time())


func _clamp_velocity() -> void:
	# velocity = velocity.clamp(Vector3.ONE * -current_max_speed, Vector3.ONE * current_max_speed)
	if velocity.length() > current_max_speed:
		velocity = velocity.normalized() * current_max_speed


func _on_speed_boost_collected(boost_amount: float) -> void:
	if is_boosting:
		return

	is_boosting = true

	current_max_speed = base_max_speed + boost_amount
	var boosted_velocity := velocity.normalized() * (velocity.length() + boost_amount)

	await (
		create_tween()
		. set_ease(Tween.EASE_IN_OUT)
		. set_trans(Tween.TRANS_CUBIC)
		. tween_property(self, "velocity", boosted_velocity, 0.5)
		. finished
	)

	print("pre")
	await get_tree().create_timer(1).timeout

	await (
		create_tween()
		. set_ease(Tween.EASE_IN_OUT)
		. set_trans(Tween.TRANS_BACK)
		. tween_property(self, "current_max_speed", base_max_speed, 2.0)
		. finished
	)

	print("tween finished")
	is_boosting = false


func _on_player_died() -> void:
	is_alive = false

	velocity = Vector3.ZERO
	mesh_container.queue_free()
