extends Area3D

@onready var audio_player := $AudioStreamPlayer3D as AudioStreamPlayer3D


func _on_body_entered(body: Node3D) -> void:
	SignalBus.repair_collected.emit()
	audio_player.play()
