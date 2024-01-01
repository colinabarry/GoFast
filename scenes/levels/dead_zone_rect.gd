extends ColorRect

@onready var viewport := get_viewport() as Viewport
@onready var viewport_size := viewport.get_visible_rect().size as Vector2


func _ready() -> void:
	custom_minimum_size = viewport_size * 0.1
