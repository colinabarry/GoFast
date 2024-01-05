extends Area3D

@export var damage_points := 1


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node3D) -> void:
	# nose
	if is_zero_approx(position.x):
		return

	# left wing
	if position.x < 0:
		pass

	# right wing
	else:
		pass
