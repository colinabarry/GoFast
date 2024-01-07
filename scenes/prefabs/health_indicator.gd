extends OmniLight3D

@export var health_area: Area3D

@onready var start_color := light_color

var base_health_points := 2
var health_points := base_health_points


func _ready() -> void:
	SignalBus.player_collided.connect(_on_player_collided)


func _on_player_collided(damage_points: int, damaged_area_name: StringName) -> void:
	if damaged_area_name != health_area.name:
		return

	health_points -= damage_points
	if health_points <= 0:
		SignalBus.player_died.emit()

	if health_points < base_health_points:
		light_color = Color.RED
	else:
		light_color = start_color
