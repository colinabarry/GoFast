extends Node

# Player signals
signal player_collided
signal player_died
signal player_position_changed(new_position: float)

# Environment signals
signal tube_area_entered

# Global signals
signal score_changed(new_score: float)
signal item_collected
signal game_paused
signal game_resumed

# UI signals
signal ui_play_pressed
signal ui_settings_pressed
signal ui_quit_pressed
