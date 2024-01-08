extends Node

#
# Player signals
signal player_collided(damage_points: int, damaged_area_name: StringName)
signal player_died

signal player_position_changed(new_position: Vector3)
signal player_velocity_changed(new_velocity: Vector3)

signal base_max_speed_changed(new_base_max_speed: float)
signal current_max_speed_changed(new_current_max_speed: float)

#
# Environment signals
signal tube_area_entered

#
# Global signals
signal game_paused
signal game_resumed
signal game_over

signal score_changed(new_score: float)
signal best_score_changed(new_best_score: float)
signal score_multiplier_changed(new_score_multiplier: float)

signal speed_boost_collected(boost_amount: float)
signal repair_collected

#
# UI signals
signal ui_play_pressed
signal ui_settings_pressed
signal ui_quit_pressed
signal ui_restart_pressed
