extends Node3D

@onready var road_straight := preload(
	"res://scenes/prefabs/environment/roads/straight.tscn"
)

var last_spawn_pos := 0


func _ready() -> void:
	SignalBus.player_position_changed.connect(_on_player_position_changed)


func _on_player_position_changed(new_position: Vector3) -> void:
	pass
