extends Node3D

var rotationVelocity : float = 10.0
var rotationTarget : float = 1
var canRotate : bool = false
@onready var spacechip: MeshInstance3D = $Spacechip

func _process(delta: float) -> void:
	if canRotate:
		spacechip.rotation.z = lerp_angle(spacechip.rotation.z, rotationTarget * GlobalInput.leftAxis.x, rotationVelocity * delta)
	else:
		spacechip.rotation.z = lerp_angle(spacechip.rotation.z, 0.0, rotationVelocity * delta)
