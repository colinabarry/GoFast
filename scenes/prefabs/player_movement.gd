class_name Player extends CharacterBody3D

const mouse_look_factor = 15
const mouse_move_factor := 25

@onready var viewport := get_viewport() as Viewport
@onready var viewport_size := viewport.get_visible_rect().size as Vector2
@onready var mesh_container := %MeshContainer as Node3D
@onready var anim_player := $AnimationPlayer as AnimationPlayer

@onready var nose_collision := $NoseCollision as CollisionShape3D
@onready var nose_marker := $MeshContainer/ShipMesh/NoseMarker as Marker3D

var world_speed := 5.0

# var max_accel := 250
var max_vel := 50
var last_elevation := 0.0
var last_journey := 0.0
var last_velocity := Vector3.ZERO
var last_position := Vector3.ZERO

var can_collide := true


func _process(delta: float) -> void:
	var mouse_pos := viewport.get_mouse_position()
	var mouse_pos_norm := (
		Vector3(
			remap(mouse_pos.x, 0, viewport_size.x, 1, -1),
			remap(mouse_pos.y, 0, viewport_size.y, 1, -1),
			0
		)
		. clamp(-Vector3.ONE, Vector3.ONE)
	)

	var look_at_vec := (
		Vector3(
			position.x + mouse_pos_norm.x * mouse_look_factor,
			position.y + mouse_pos_norm.y * mouse_look_factor,
			position.z + 10
		)
		- position
	)

	# print("mouse norm: \t", mouse_pos_norm)

	#

	mesh_container.look_at(look_at_vec + position + Vector3(0, 2.5, 0))
	nose_collision.global_position = nose_marker.global_position

	var push_vector := Vector3.ZERO

	if abs(mouse_pos_norm.x) > 0.1:
		push_vector.x = (look_at_vec.normalized().x * mouse_move_factor * delta)
		# + mouse_pos_norm.x * mouse_move_factor
	else:
		push_vector.x = 0.0
		velocity.x = lerp(velocity.x, 0.0, 0.1)

	if abs(mouse_pos_norm.y) > 0.1:
		push_vector.y = (look_at_vec.normalized().y * mouse_move_factor * delta)
		# + mouse_pos_norm.y * mouse_move_factor
	else:
		push_vector.y = 0.0
		velocity.y = lerp(velocity.y, 0.0, 0.1)

	push_vector.z = (look_at_vec.normalized().z * world_speed * delta)
	print(push_vector)

	velocity += push_vector

	if Input.is_action_just_pressed("move_dash_left"):
		anim_player.play("dash_left")

	if Input.is_action_just_pressed("move_dash_right"):
		anim_player.play("dash_right")

	last_velocity = velocity

	var collision := move_and_collide(velocity * delta)

	if can_collide and collision:
		SignalBus.player_collided.emit()
		can_collide = false

		var vec_to_collision := collision.get_position() - position
		velocity -= vec_to_collision.normalized() * 15
		velocity.z = last_velocity.z / 2

		# await get_tree().create_timer(0.5).timeout
		can_collide = true

	velocity = velocity.clamp(Vector3.ONE * -max_vel, Vector3.ONE * max_vel)

	#

	if !position.is_equal_approx(last_position):
		last_position = position
		SignalBus.player_position_changed.emit(position)
