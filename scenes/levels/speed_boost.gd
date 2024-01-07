extends Area3D

enum Power {
	SMALL = 15,
	MEDIUM = 25,
	LARGE = 75,
}

@export var power := Power.SMALL

@onready var audio_player := $AudioStreamPlayer3D as AudioStreamPlayer3D


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

		audio_player.pitch_scale = remap(power, Power.SMALL, Power.LARGE, 0.8, 1.2)
		audio_player.play()
		await audio_player.finished

		queue_free()
