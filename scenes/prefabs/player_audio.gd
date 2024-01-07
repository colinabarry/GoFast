extends Node3D

@export var engine_sound: AudioStream
@export var horn_sound: AudioStream
@export var collision_sound: AudioStream
@export var death_sound: AudioStream

@onready var engine_sound_player := AudioStreamPlayer.new() as AudioStreamPlayer
@onready var horn_sound_player := AudioStreamPlayer.new() as AudioStreamPlayer
@onready var collision_sound_player := AudioStreamPlayer3D.new() as AudioStreamPlayer3D
@onready var death_sound_player := AudioStreamPlayer3D.new() as AudioStreamPlayer3D

var base_max_speed := 0.0
var can_collide := true


func _ready() -> void:
	engine_sound_player.stream = engine_sound
	engine_sound_player.bus = "SFX_Engine"
	add_child(engine_sound_player)

	horn_sound_player.stream = horn_sound
	horn_sound_player.bus = "SFX_Horn"
	add_child(horn_sound_player)

	collision_sound_player.stream = collision_sound
	collision_sound_player.bus = "SFX"
	add_child(collision_sound_player)

	death_sound_player.stream = death_sound
	death_sound_player.bus = "SFX"
	add_child(death_sound_player)

	SignalBus.player_velocity_changed.connect(_on_player_velocity_changed)
	SignalBus.base_max_speed_changed.connect(_on_base_max_speed_changed)
	SignalBus.player_collided.connect(_on_player_collided)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("horn_honk"):
		if horn_sound_player.playing and horn_sound_player.stream_paused:
			horn_sound_player.stream_paused = false
		else:
			horn_sound_player.play()

	if Input.is_action_just_released("horn_honk"):
		horn_sound_player.stream_paused = true


func _on_player_velocity_changed(new_velocity: Vector3) -> void:
	var new_speed := new_velocity.length()
	var new_pitch := remap(new_speed, 0, base_max_speed, 0.75, 1.0)
	engine_sound_player.pitch_scale = new_pitch
	if !engine_sound_player.playing:
		engine_sound_player.play()


func _on_base_max_speed_changed(new_base_max_speed: float) -> void:
	base_max_speed = new_base_max_speed


func _on_player_collided(_damage_points: int, _damaged_area_name: StringName) -> void:
	if !can_collide:
		return

	can_collide = false

	collision_sound_player.play()
	death_sound_player.pitch_scale = 1.5
	death_sound_player.volume_db = -15.0
	death_sound_player.play()
	# await collision_sound_player.finished
	await death_sound_player.finished

	death_sound_player.pitch_scale = 1.0
	death_sound_player.volume_db = 0.0

	can_collide = true
