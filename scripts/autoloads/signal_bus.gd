extends Node

signal player_collided
signal player_died
signal player_velocity_changed(new_velocity: Vector3)

signal score_changed(new_score: float)

signal item_collected

signal world_speed_changed(new_speed: float)