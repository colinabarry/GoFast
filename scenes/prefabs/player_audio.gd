extends Node3D

@export var engine_sound: AudioStream
@export var horn_sound: AudioStream
@export var collision_sound: AudioStream
@export var death_sound: AudioStream

@onready var engine_sound_player := AudioStreamPlayer.new()
@onready var horn_sound_player := AudioStreamPlayer.new()
@onready var collision_sound_player := AudioStreamPlayer3D.new()
@onready var death_sound_player := AudioStreamPlayer3D.new()

var base_max_speed := 0.0


func _ready() -> void:
	engine_sound_player.stream = engine_sound
	add_child(engine_sound_player)

	add_child(horn_sound_player)

	collision_sound_player.stream = collision_sound
	add_child(collision_sound_player)

	add_child(death_sound_player)

	SignalBus.player_velocity_changed.connect(_on_player_velocity_changed)
	SignalBus.base_max_speed_changed.connect(_on_base_max_speed_changed)
	SignalBus.player_collided.connect(_on_player_collided)


func _on_player_velocity_changed(new_velocity: Vector3) -> void:
	var new_speed := new_velocity.length()
	var new_pitch := remap(new_speed, 0, base_max_speed, 0.5, 1.0)
	engine_sound_player.pitch_scale = new_pitch
	if !engine_sound_player.playing:
		engine_sound_player.play()


func _on_base_max_speed_changed(new_base_max_speed: float) -> void:
	base_max_speed = new_base_max_speed


func _on_player_collided(_damage_points: int, push_direction: Vector3) -> void:
	collision_sound_player.position.x = push_direction.x * 10
	print(collision_sound_player.position.x)

	collision_sound_player.play()
