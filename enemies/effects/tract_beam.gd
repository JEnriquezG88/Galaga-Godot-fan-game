extends Node3D
var objetiveScale : Vector3 = Vector3(1.0,1.0,1.0)

func _init() -> void:
	scale = Vector3(0.0,0.0,0.0)

func _process(delta: float) -> void:
	scale = lerp(scale, objetiveScale, 5 * delta)

func setScale(value: float):
	objetiveScale = Vector3(value, value, value)
