extends Area3D

enum Power {
	SMALL = 15,
	MEDIUM = 25,
	LARGE = 75,
}

@export var power := Power.SMALL


func _ready() -> void:
	match power:
		Power.SMALL:
			$SubViewport/Label.text = ">"
		Power.MEDIUM:
			$SubViewport/Label.text = ">>"
		Power.LARGE:
			$SubViewport/Label.text = ">>>"


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		SignalBus.speed_boost_collected.emit(power)
		print(str(power))
		queue_free()
