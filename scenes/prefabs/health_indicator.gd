extends OmniLight3D

@export var health_area: Area3D

@onready var start_color := light_color

var base_health_points := 2
var health_points := base_health_points

static var is_alive := true


func _ready() -> void:
	SignalBus.player_collided.connect(_on_player_collided)
	SignalBus.repair_collected.connect(_on_repair_collected)


func _on_player_collided(damage_points: int, damaged_area_name: StringName) -> void:
	if damaged_area_name != health_area.name:
		return
	_set_health_points(health_points - damage_points)


func _on_repair_collected() -> void:
	_set_health_points(base_health_points)


func _set_health_points(new_health_points: int) -> void:
	health_points = new_health_points

	if health_points <= 0 and is_alive:
		is_alive = false
		SignalBus.player_died.emit()

	if health_points < base_health_points:
		light_color = Color.RED
	else:
		light_color = start_color
